-- Usuarios (información adicional a Firebase Auth)
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  name TEXT,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categorías de gastos
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  icon TEXT,
  created_by TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users (id)
);

-- Métodos de pago
CREATE TABLE payment_methods (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  icon TEXT,
  created_by TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users (id)
);

-- Gastos
CREATE TABLE expenses (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  description TEXT NOT NULL,
  amount REAL NOT NULL,
  date DATE NOT NULL,
  category_id INTEGER NOT NULL,
  payment_method_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  receipt_url TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories (id),
  FOREIGN KEY (payment_method_id) REFERENCES payment_methods (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Grupos familiares
CREATE TABLE groups (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  created_by TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users (id)
);

-- Miembros de grupos
CREATE TABLE group_members (
  group_id INTEGER NOT NULL,
  user_id TEXT NOT NULL,
  role TEXT NOT NULL, -- 'admin', 'member'
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (group_id, user_id),
  FOREIGN KEY (group_id) REFERENCES groups (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Insertar datos iniciales
INSERT INTO categories (name, icon) VALUES 
  ('Alimentación', 'shopping-cart'),
  ('Servicios', 'lightbulb'),
  ('Transporte', 'car'),
  ('Entretenimiento', 'film'),
  ('Salud', 'heart'),
  ('Hogar', 'home'),
  ('Educación', 'book'),
  ('Otros', 'tag');

INSERT INTO payment_methods (name, icon) VALUES 
  ('Efectivo', 'money-bill'),
  ('Tarjeta de Crédito', 'credit-card'),
  ('Tarjeta de Débito', 'credit-card'),
  ('Transferencia Bancaria', 'university'),
  ('Billetera Digital', 'wallet'); 