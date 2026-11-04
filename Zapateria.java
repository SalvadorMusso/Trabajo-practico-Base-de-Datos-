import java.util.HashMap;

public class Zapateria{
    HashMap<Integer, Proveedor>proveedor=new HashMap<>();

    //Método que sirve para insertar los datos del proveedor.
    public void InsertProveedor(int cuit, Proveedor datosProveedor){
        proveedor.put(cuit, datosProveedor);
    }
    //Método que elimina un proveedor.
    public void EliminarProveedor(int cuit){
        proveedor.remove(cuit);
    }
    
    //Método que lista todos los proveedores.
    public String ListaProveedores() {
        if (proveedor.isEmpty()) {
            return "No hay proveedores registrados.";
        }

        StringBuilder texto = new StringBuilder();
        texto.append("--- Lista de Proveedores ---\n");

        for (Integer cuit : proveedor.keySet()) {
            
            Proveedor datos = proveedor.get(cuit);
            
            texto.append("CUIT: ").append(cuit)
                 .append(" | Datos: ").append(datos) 
                 .append("\n");
        }
        return texto.toString();
    }
}