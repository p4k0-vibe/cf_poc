import { useState, useEffect } from 'react';
import { auth } from '../firebase/config';

interface Expense {
  id: string;
  description: string;
  amount: number;
  category: string;
  paymentMethod: string;
  date: string;
  userId: string;
}

const Dashboard = () => {
  const [expenses, setExpenses] = useState<Expense[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Mock data for development
  const mockExpenses: Expense[] = [
    {
      id: '1',
      description: 'Supermercado',
      amount: 125.50,
      category: 'Alimentación',
      paymentMethod: 'Tarjeta de crédito',
      date: '2023-05-01',
      userId: auth.currentUser?.uid || ''
    },
    {
      id: '2',
      description: 'Gasolina',
      amount: 50.00,
      category: 'Transporte',
      paymentMethod: 'Efectivo',
      date: '2023-05-03',
      userId: auth.currentUser?.uid || ''
    },
    {
      id: '3',
      description: 'Netflix',
      amount: 15.99,
      category: 'Entretenimiento',
      paymentMethod: 'Débito automático',
      date: '2023-05-05',
      userId: auth.currentUser?.uid || ''
    }
  ];

  useEffect(() => {
    // Simular carga de datos desde el backend
    const fetchExpenses = async () => {
      try {
        // En producción, aquí se haría una llamada a la API
        // const response = await fetch('https://api.example.com/expenses');
        // const data = await response.json();

        // Por ahora usamos datos de prueba
        setTimeout(() => {
          setExpenses(mockExpenses);
          setLoading(false);
        }, 1000);
      } catch (err: any) {
        setError('Error al cargar los gastos');
        setLoading(false);
      }
    };

    fetchExpenses();
  }, []);

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  if (error) {
    return <div className="text-red-500 text-center">{error}</div>;
  }

  const totalExpenses = expenses.reduce((total, expense) => total + expense.amount, 0);

  return (
    <div>
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-800 mb-2">Dashboard de Gastos</h1>
        <div className="bg-blue-100 p-4 rounded-lg">
          <p className="text-lg">Total de gastos: <span className="font-bold">${totalExpenses.toFixed(2)}</span></p>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <div className="px-4 py-5 sm:px-6 bg-gray-50">
          <h2 className="text-lg font-medium text-gray-900">Gastos Recientes</h2>
        </div>

        <div className="border-t border-gray-200">
          <ul className="divide-y divide-gray-200">
            {expenses.length === 0 ? (
              <li className="px-4 py-5">No hay gastos registrados</li>
            ) : (
              expenses.map((expense) => (
                <li key={expense.id} className="px-4 py-4 sm:px-6 hover:bg-gray-50">
                  <div className="flex items-center justify-between">
                    <div>
                      <p className="text-sm font-medium text-blue-600 truncate">{expense.description}</p>
                      <p className="text-sm text-gray-500">
                        <span className="mr-2">{expense.category}</span>
                        <span className="mr-2">•</span>
                        <span>{expense.paymentMethod}</span>
                      </p>
                      <p className="text-xs text-gray-400">{expense.date}</p>
                    </div>
                    <div className="ml-2 flex-shrink-0">
                      <span className="font-medium">${expense.amount.toFixed(2)}</span>
                    </div>
                  </div>
                </li>
              ))
            )}
          </ul>
        </div>
      </div>

      <div className="mt-8 text-center">
        <button className="bg-blue-600 text-white py-2 px-6 rounded-full hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
          Agregar Nuevo Gasto
        </button>
      </div>
    </div>
  );
};

export default Dashboard; 