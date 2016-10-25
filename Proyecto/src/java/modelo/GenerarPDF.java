/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import ClasesGenericas.Cliente;
import ClasesGenericas.Producto;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author panle
 */
public class GenerarPDF {

    public void nuevoReporteClientes(ArrayList<Cliente> Datos) throws IOException {
        // Se crea el documento Document documento = new Document();
        // Se crea el OutputStream para el fichero donde queremos dejar el pdf.
        Document documento = null;
        try {
            FileOutputStream ficheroPdf = new FileOutputStream("C:\\Users\\panle\\Documents\\ReporteClientes.pdf");
            documento = new Document();       // Se asocia el documento al OutputStream y se indica que el espaciado entre
            // lineas sera de 20. Esta llamada debe hacerse antes de abrir el documento
            PdfWriter.getInstance(documento, ficheroPdf).setInitialLeading(20);

            // Se abre el documento.
            documento.open();
            documento.add(new Paragraph("REPORTE CLIENTES",
                    FontFactory.getFont("ARIAL", // fuente
                            16, // tamaño
                            Font.ITALIC, // estilo
                            BaseColor.BLACK)));             // color

            PdfPTable tabla = new PdfPTable(3);
            Font font = new Font(FontFamily.COURIER, 6, Font.BOLD, BaseColor.BLACK);
            PdfPCell cell = new PdfPCell(new Phrase("algo", font));
            documento.add(new Paragraph("\n"));

            Image img = Image.getInstance("C:\\logo.png");
            documento.add(img);
            documento.add(new Paragraph("\n"));
            int conta = 0;

            cell.setBorder(Rectangle.TITLE);
            tabla.addCell("NOMBRE COMLETO");
            tabla.addCell("USUARIO");
            tabla.addCell("NIT");
            tabla.addCell("NO DOCUMENTO");
            tabla.addCell("PROFESION");
            tabla.addCell("TELÉFONO CELULAR");
            tabla.addCell("TELÉFONO RESIDENCIA");
            tabla.addCell("DIRECCIÓN");
            tabla.addCell("CIUDAD");

            while (conta < Datos.size()) {
                cell.setBorder(Rectangle.NO_BORDER);
                tabla.addCell(Datos.get(conta).getNOMBRE() + " " + Datos.get(conta).getAPELLIDO());
                tabla.addCell(Datos.get(conta).getUSUARIO());
                tabla.addCell(Datos.get(conta).getNIT());
                tabla.addCell(Datos.get(conta).getNUMERO_DOC());
                tabla.addCell(Datos.get(conta).getPROFESION());
                tabla.addCell(Datos.get(conta).getTEL_CEL());
                tabla.addCell(Datos.get(conta).getTEL_RESIDENCIA());
                tabla.addCell(Datos.get(conta).getDIRECCION());
                tabla.addCell(Datos.get(conta).getCIUDAD());
                conta++;
            }

            documento.add(tabla);
            documento.close();

        } catch (FileNotFoundException | DocumentException e) {
            System.out.println("Error al generar Reporte Clientes, por:");
            e.printStackTrace();
        }
    }

    public void nuevoReporteProductos(ArrayList<Producto> Datos) throws IOException {
        // Se crea el documento Document
        // Se crea el OutputStream para el fichero donde queremos dejar el pdf.
        Document documento = null;
        try {
            //Direccion root
            FileOutputStream ficheroPdf = new FileOutputStream("C:\\Users\\panle\\Documents\\ReporteProductos.pdf");
            //FileOutputStream ficheroPdf = new FileOutputStream("user.dir/tmp", "ReporteProductos.pdf");
            //File tempfile = new File("user.dir/tmp", "tempfile.txt");    
            documento = new Document();
            // Se asocia el documento al OutputStream y se indica que el espaciado entre
            // lineas sera de 20. Esta llamada debe hacerse antes de abrir el documento
            PdfWriter.getInstance(documento, ficheroPdf).setInitialLeading(20);

            // Se abre el documento
            documento.open();
            documento.add(new Paragraph("REPORTE PRODUCTOS",
                    FontFactory.getFont("ARIAL", // fuente
                            16, // tamaño
                            Font.ITALIC, // estilo
                            BaseColor.BLACK)));             // color

            PdfPTable tabla = new PdfPTable(3);//#campos(columnas) para la tabla
            Font font = new Font(FontFamily.COURIER, 6, Font.BOLD, BaseColor.BLACK);
            PdfPCell cell = new PdfPCell(new Phrase("Celdas", font));

            documento.add(new Paragraph("\n"));

            Image img = Image.getInstance("C:\\Users\\logo.png");
            documento.add(img);
            documento.add(new Paragraph("\n"));

            int conta = 0;

            cell.setBorder(Rectangle.TITLE);
            tabla.addCell("DESCRIPCION");
            tabla.addCell("REFERENCIA");
            tabla.addCell("TIPO");

            while (conta < Datos.size()) {
                cell.setBorder(Rectangle.NO_BORDER);
                tabla.addCell(Datos.get(conta).getDESCRIPCION());
                tabla.addCell(Datos.get(conta).getREFERENCIA());
                tabla.addCell(Datos.get(conta).getTIPO());
                conta++;
            }

            documento.add(tabla);
            documento.close();

        } catch (FileNotFoundException | DocumentException e) {
            System.out.println("Error al generar Reporte Productos, por:");
            e.printStackTrace();
        }
    }

}
