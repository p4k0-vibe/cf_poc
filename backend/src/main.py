import json
import os
from datetime import datetime
import firebase_admin
from firebase_admin import auth, credentials
from cloudflare.d1 import D1Client
from cloudflare.r2 import R2Client

# Firebase setup
firebase_app = None
try:
    # En producción, las credenciales deberían estar almacenadas de forma segura
    # Por ahora, usamos una variable de entorno para el ID del proyecto
    if not firebase_app:
        firebase_project_id = os.environ.get("FIREBASE_PROJECT_ID")
        firebase_app = firebase_admin.initialize_app(options={
            'projectId': firebase_project_id,
        })
except Exception as e:
    print(f"Error initializing Firebase: {e}")

# Allowed origins for CORS
ALLOWED_ORIGINS = os.environ.get("ALLOWED_ORIGINS", "").split(",")

# Helper functions
def verify_firebase_token(token):
    try:
        decoded_token = auth.verify_id_token(token)
        return decoded_token
    except Exception as e:
        return None

def cors_headers(request):
    origin = request.headers.get('Origin', '')
    
    # Check if the origin is allowed
    if origin in ALLOWED_ORIGINS:
        return {
            'Access-Control-Allow-Origin': origin,
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
            'Access-Control-Allow-Credentials': 'true'
        }
    
    # Default response
    return {
        'Access-Control-Allow-Origin': ALLOWED_ORIGINS[0] if ALLOWED_ORIGINS else '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization'
    }

def parse_json_body(request):
    try:
        return json.loads(request.body)
    except:
        return None

def error_response(message, status=400):
    return Response(
        json.dumps({"error": message}),
        headers={"Content-Type": "application/json"},
        status=status
    )

# Request handler
def handle_request(request, env):
    # Handle preflight requests
    if request.method == "OPTIONS":
        return Response(
            None,
            headers=cors_headers(request),
            status=204
        )
    
    # Get headers for CORS
    headers = cors_headers(request)
    headers["Content-Type"] = "application/json"
    
    # All non-authentication routes require authentication
    authorization = request.headers.get('Authorization', '')
    path = request.url.path
    
    if not path.startswith('/api/auth/') and not authorization.startswith('Bearer '):
        return error_response("No authorization token provided", 401)
    
    # Verify token for non-auth endpoints
    if not path.startswith('/api/auth/') and authorization.startswith('Bearer '):
        token = authorization.split(' ')[1]
        decoded_token = verify_firebase_token(token)
        
        if not decoded_token:
            return error_response("Invalid token", 401)
        
        # Add user ID to request context
        request.context.user_id = decoded_token.get('uid')
    
    # Route handler
    if path.startswith('/api/expenses'):
        return handle_expenses(request, env, headers)
    elif path.startswith('/api/categories'):
        return handle_categories(request, env, headers)
    elif path.startswith('/api/payment-methods'):
        return handle_payment_methods(request, env, headers)
    elif path.startswith('/api/receipts'):
        return handle_receipts(request, env, headers)
    else:
        return error_response("Not found", 404)

# Endpoints implementations
def handle_expenses(request, env, headers):
    db = env.DB
    user_id = request.context.user_id
    
    # GET all expenses
    if request.method == "GET":
        # Here you would query the database
        # Example query: SELECT * FROM expenses WHERE user_id = ?
        # For now, we'll return a mock response
        expenses = [
            {
                "id": "1",
                "description": "Grocery shopping",
                "amount": 125.50,
                "category_id": "1",
                "payment_method_id": "2",
                "date": "2023-05-01",
                "user_id": user_id
            }
        ]
        
        return Response(
            json.dumps(expenses),
            headers=headers,
            status=200
        )
    
    # POST new expense
    elif request.method == "POST":
        data = parse_json_body(request)
        
        if not data:
            return error_response("Invalid request body", 400)
        
        # Required fields
        required_fields = ["description", "amount", "category_id", "payment_method_id", "date"]
        for field in required_fields:
            if field not in data:
                return error_response(f"Missing required field: {field}", 400)
        
        # Create expense in DB (mock implementation)
        # In a real application, you would insert this into the database
        expense = {
            "id": "new_id",  # This would be generated by the database
            "description": data["description"],
            "amount": data["amount"],
            "category_id": data["category_id"],
            "payment_method_id": data["payment_method_id"],
            "date": data["date"],
            "user_id": user_id,
            "created_at": datetime.now().isoformat()
        }
        
        return Response(
            json.dumps(expense),
            headers=headers,
            status=201
        )
    
    # Other methods would go here (PUT, DELETE)
    else:
        return error_response("Method not allowed", 405)

def handle_categories(request, env, headers):
    # Implementation for categories
    if request.method == "GET":
        categories = [
            {"id": "1", "name": "Groceries", "icon": "shopping-cart"},
            {"id": "2", "name": "Utilities", "icon": "lightbulb"},
            {"id": "3", "name": "Transport", "icon": "car"},
            {"id": "4", "name": "Entertainment", "icon": "film"}
        ]
        
        return Response(
            json.dumps(categories),
            headers=headers,
            status=200
        )
    else:
        return error_response("Method not allowed", 405)

def handle_payment_methods(request, env, headers):
    # Implementation for payment methods
    if request.method == "GET":
        payment_methods = [
            {"id": "1", "name": "Cash", "icon": "money-bill"},
            {"id": "2", "name": "Credit Card", "icon": "credit-card"},
            {"id": "3", "name": "Debit Card", "icon": "credit-card"},
            {"id": "4", "name": "Bank Transfer", "icon": "university"}
        ]
        
        return Response(
            json.dumps(payment_methods),
            headers=headers,
            status=200
        )
    else:
        return error_response("Method not allowed", 405)

def handle_receipts(request, env, headers):
    # Implementation for handling receipt uploads to R2
    if request.method == "POST":
        # This would handle file uploads to R2
        return Response(
            json.dumps({"message": "Receipt upload endpoint (not implemented)"}),
            headers=headers,
            status=501
        )
    else:
        return error_response("Method not allowed", 405)

# Main worker entry point
def on_fetch(request, env):
    try:
        return handle_request(request, env)
    except Exception as e:
        return error_response(f"Server error: {str(e)}", 500) 