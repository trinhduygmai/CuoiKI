import { BrowserRouter } from 'react-router-dom';
import { GlobalProvider } from './context/GlobalContext';
import AppRouter from './navigation/app_router';

export default function App() {
  return (
    <GlobalProvider>
      <div className="min-h-screen bg-zinc-200 flex items-center justify-center p-4">
        <div className="w-full max-w-[400px] h-[850px] bg-white rounded-[4rem] shadow-2xl relative overflow-hidden border-[10px] border-zinc-900 ring-4 ring-zinc-100">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-32 h-7 bg-zinc-900 rounded-b-3xl z-50 flex items-center justify-center">
            <div className="w-12 h-1 bg-zinc-800 rounded-full" />
          </div>
          
          <div className="h-full overflow-hidden bg-white">
            <BrowserRouter>
              <AppRouter />
            </BrowserRouter>
          </div>
        </div>
      </div>
    </GlobalProvider>
  );
}
