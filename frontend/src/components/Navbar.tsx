import { Link, useNavigate } from 'react-router-dom';
import { signOut } from 'firebase/auth';
import { auth } from '../firebase/config';
import { User } from 'firebase/auth';

interface NavbarProps {
  user: User | null;
}

const Navbar = ({ user }: NavbarProps) => {
  const navigate = useNavigate();

  const handleLogout = async () => {
    try {
      await signOut(auth);
      navigate('/login');
    } catch (error) {
      console.error('Error al cerrar sesión:', error);
    }
  };

  return (
    <nav className="bg-blue-600 text-white">
      <div className="container mx-auto px-4 py-4 flex justify-between items-center">
        <Link to="/" className="text-xl font-bold">Gastos Familiares</Link>
        <div className="flex items-center space-x-4">
          {user ? (
            <>
              <span className="hidden md:inline">Hola, {user.email?.split('@')[0]}</span>
              <button
                onClick={handleLogout}
                className="bg-red-500 hover:bg-red-600 px-4 py-2 rounded"
              >
                Salir
              </button>
            </>
          ) : (
            <>
              <Link to="/login" className="hover:underline">Iniciar Sesión</Link>
              <Link to="/register" className="bg-white text-blue-600 hover:bg-gray-100 px-4 py-2 rounded">
                Registrarse
              </Link>
            </>
          )}
        </div>
      </div>
    </nav>
  );
};

export default Navbar; 