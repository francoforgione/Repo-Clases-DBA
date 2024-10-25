package abmc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    // Método estático para obtener una conexión a la base de datos
    public static Connection obtenerConexion() {
        Connection conexion = null;
        try {
            // Carga el driver JDBC para SQLite
            Class.forName("org.sqlite.JDBC");
            
            // Establece la URL de la base de datos SQLite
            String url = "jdbc:sqlite:src/abmc/colegio.db";
            
            // Obtiene la conexión a la base de datos
            conexion = DriverManager.getConnection(url);
            
            System.out.println("Conexión a la base de datos establecida exitosamente.");
        } catch (ClassNotFoundException e) {
            System.err.println("No se pudo cargar el driver JDBC para SQLite: " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos: " + e.getMessage());
        }
        
        return conexion;
    }
}
