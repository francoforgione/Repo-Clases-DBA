package abmc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Conexion {

    public static Connection obtenerConexion() throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        
        String url = "jdbc:postgresql://localhost:5432/colegio";
        
        Properties props = new Properties();
        props.setProperty("user", "postgres");
        props.setProperty("password", "2595");

        // Especifica el controlador
        Class.forName("org.postgresql.Driver");

        return DriverManager.getConnection(url, props);
    }
}
