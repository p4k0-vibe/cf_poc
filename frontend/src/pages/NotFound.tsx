import { Link } from 'react-router-dom';

const NotFound = () => {
  return (
    <div className="flex flex-col items-center justify-center min-h-[50vh] text-center px-4">
      <h1 className="text-6xl font-bold text-gray-800 mb-4">404</h1>
      <p className="text-2xl font-medium text-gray-600 mb-8">Página no encontrada</p>
      <p className="text-gray-500 mb-8">La página que estás buscando no existe o ha sido movida.</p>
      <Link to="/" className="bg-blue-600 text-white py-2 px-6 rounded-md hover:bg-blue-700 transition-colors">
        Volver al inicio
      </Link>
    </div>
  );
};

export default NotFound; 