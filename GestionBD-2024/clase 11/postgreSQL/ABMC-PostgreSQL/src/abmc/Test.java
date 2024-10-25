package abmc;

import java.sql.SQLException;
import java.util.Scanner;

public class Test {
    public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        Conexion.obtenerConexion();
        System.out.println("Conexion OK!");
        
        System.out.println("Consultar Todos");
        Alumno.consultarTodos();
        
        System.out.println("------------------");
        
        Scanner lector = new Scanner(System.in);
        System.out.println("Decime el nombre: " );
        String nombre = lector.next();
        Alumno.consultarUno(nombre);
        
    }
}
