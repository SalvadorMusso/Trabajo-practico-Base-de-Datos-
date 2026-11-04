import java.util.Scanner;

public class Zapateria {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int opcion = -1;

        while (opcion != 0) {
            System.out.println("=== GESTIÓN DE ZAPATERÍA CALZADOS S.A. ===");
            System.out.println("1. Listar proveedores");
            System.out.println("2. Insertar nuevo proveedor");
            System.out.println("3. Eliminar proveedor por CUIT");
            System.out.println("0. Salir");
            System.out.print("Seleccione una opción: ");

            opcion = scanner.nextInt();
            scanner.nextLine(); // Limpiar el buffer

            switch (opcion) {
                case 1:
                    Proveedor.listar();
                    break;
                case 2:
                    System.out.print("Ingrese CUIT: ");
                    String cuit = scanner.nextLine();
                    System.out.print("Ingrese Razón Social: ");
                    String razonSocial = scanner.nextLine();
                    System.out.print("Ingrese Dirección: ");
                    String direccion = scanner.nextLine();
                    System.out.print("Ingrese Teléfono: ");
                    String telefono = scanner.nextLine();
                    System.out.print("Ingrese Celular: ");
                    String celular = scanner.nextLine();

                    Proveedor.insertar(cuit, razonSocial, direccion, telefono, celular);
                    break;
                case 3:
                    System.out.print("Ingrese el CUIT del proveedor a eliminar: ");
                    String cuitEliminar = scanner.nextLine();
                    Proveedor.eliminarPorCuit(cuitEliminar);
                    break;
                case 0:
                    System.out.println("Saliendo del programa...");
                    break;
                default:
                    System.out.println("Opción no válida.");
            }
        }
        scanner.close();
    }
}