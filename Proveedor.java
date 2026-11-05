import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Proveedor {

    private static final String URL = "jdbc:postgresql://localhost:5432/calzados_sa";
    private static final String USER = "postgres";
    private static final String PASSWORD = "tu_contraseña_aqui"; // Recordá poner tu clave

    public static Connection conectar() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("Error de conexión: " + e.getMessage());
        }
        return conn;
    }

    // 1. Insertar proveedor
    public static void insertar(String cuit, String razonSocial, String direccion, String telefono, String celular) {
        // Consultas ajustadas a los nombres reales del script BaseDeDatos.sql
        String sqlProv = "INSERT INTO Proveedor (Cuit, RazSoci, Direccion, TelefonoFijo) VALUES (?, ?, ?, ?)";
        String sqlCel = "INSERT INTO MultEvCelus (IdProveedor, Celus) VALUES (?, ?)";

        // Statement.RETURN_GENERATED_KEYS nos permite recuperar el IdProveedor automático
        try (Connection conn = conectar(); 
             PreparedStatement pstmtProv = conn.prepareStatement(sqlProv, Statement.RETURN_GENERATED_KEYS)) {

            pstmtProv.setString(1, cuit);
            pstmtProv.setString(2, razonSocial);
            pstmtProv.setString(3, direccion);
            pstmtProv.setString(4, telefono);
            pstmtProv.executeUpdate();

            // Recuperamos el ID generado para guardarle el celular
            try (ResultSet rs = pstmtProv.getGeneratedKeys()) {
                if (rs.next()) {
                    int idProveedor = rs.getInt(1);

                    try (PreparedStatement pstmtCel = conn.prepareStatement(sqlCel)) {
                        pstmtCel.setInt(1, idProveedor);
                        pstmtCel.setString(2, celular);
                        pstmtCel.executeUpdate();
                    }
                }
            }
            System.out.println("-> Proveedor registrado con éxito.");

        } catch (SQLException e) {
            System.out.println("Error al insertar: " + e.getMessage());
        }
    }

    // 2. Eliminar proveedor por CUIT
    public static void eliminarPorCuit(String cuit) {
        String sql = "DELETE FROM Proveedor WHERE Cuit = ?";
        try (Connection conn = conectar(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, cuit);
            int filasAfectadas = pstmt.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Al estar configurado ON DELETE CASCADE, esto borra los celulares automáticamente
                System.out.println("-> Proveedor eliminado con éxito.");
            } else {
                System.out.println("-> No se encontró ningún proveedor con CUIT: " + cuit);
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar: " + e.getMessage());
        }
    }

    // 3. Listar todos los proveedores
    public static void listar() {
        // Hacemos un JOIN para traer el celular desde la tabla MultEvCelus
        String sql = "SELECT p.Cuit, p.RazSoci, p.Direccion, p.TelefonoFijo, string_agg(m.Celus, ', ') as Celulares " +
                     "FROM Proveedor p LEFT JOIN MultEvCelus m ON p.IdProveedor = m.IdProveedor " +
                     "GROUP BY p.IdProveedor, p.Cuit, p.RazSoci, p.Direccion, p.TelefonoFijo";

        try (Connection conn = conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n--- LISTA DE PROVEEDORES ---");
            while (rs.next()) {
                String cels = rs.getString("Celulares") != null ? rs.getString("Celulares") : "Ninguno";
                System.out.println("CUIT: " + rs.getString("Cuit") +
                        " | Razón Social: " + rs.getString("RazSoci") +
                        " | Dir: " + rs.getString("Direccion") +
                        " | Tel: " + rs.getString("TelefonoFijo") +
                        " | Cel: " + cels);
            }
            System.out.println("-----------------------------\n");
            
        } catch (SQLException e) {
            System.out.println("Error al listar: " + e.getMessage());
        }
    }
}