import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Proveedor {

    private static final String URL = "jdbc:postgresql://localhost:5432/calzados_sa";
    private static final String USER = "postgres";
    private static final String PASSWORD = "tu_contraseña_aqui"; // Reemplazar por tu clave

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
        String sql = "INSERT INTO proveedor (cuit, razon_social, direccion, telefono, celular) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = conectar(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cuit);
            pstmt.setString(2, razonSocial);
            pstmt.setString(3, direccion);
            pstmt.setString(4, telefono);
            pstmt.setString(5, celular);
            pstmt.executeUpdate();
            System.out.println("-> Proveedor registrado con éxito.");
        } catch (SQLException e) {
            System.out.println("Error al insertar: " + e.getMessage());
        }
    }

    // 2. Eliminar proveedor por CUIT
    public static void eliminarPorCuit(String cuit) {
        String sql = "DELETE FROM proveedor WHERE cuit = ?";
        try (Connection conn = conectar(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cuit);
            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas > 0) {
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
        String sql = "SELECT * FROM proveedor";
        try (Connection conn = conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            System.out.println("\n--- LISTA DE PROVEEDORES ---");
            while (rs.next()) {
                System.out.println("CUIT: " + rs.getString("cuit") +
                        " | Razón Social: " + rs.getString("razon_social") +
                        " | Dir: " + rs.getString("direccion") +
                        " | Tel: " + rs.getString("telefono") +
                        " | Cel: " + rs.getString("celular"));
            }
            System.out.println("-----------------------------\n");
        } catch (SQLException e) {
            System.out.println("Error al listar: " + e.getMessage());
        }
    }
}