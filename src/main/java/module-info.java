module com.bariqqazi.simulatorecu {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.media;
    requires java.sql;

    exports com.bariqqazi.simulatorecu;
    opens com.bariqqazi.simulatorecu to javafx.fxml;
}