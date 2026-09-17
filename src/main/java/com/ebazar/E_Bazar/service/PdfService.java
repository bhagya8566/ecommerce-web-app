package com.ebazar.E_Bazar.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import org.springframework.stereotype.Service;

import java.io.*;
import java.awt.Color;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class PdfService {

    // items = {{productName, qty, price, imagePath}, ...}
    public ByteArrayInputStream generateInvoicePdf (
            String orderId,
            String customerName,
            String[][] items,
            double totalAmount,
            double discountAmount,
            double payableAmount
    ) {

        Document document = new Document(PageSize.A4, 40, 40, 60, 50);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // -------- Header ----------
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, Color.BLUE);
            Paragraph title = new Paragraph("LuxeVera Invoice", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Font subFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Color.DARK_GRAY);
            Paragraph tagline = new Paragraph("Your Trusted Online Shopping Partner", subFont);
            tagline.setAlignment(Element.ALIGN_CENTER);
            document.add(tagline);

            document.add(new Paragraph(" "));

            // -------- Order Details ----------
            Font infoFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Color.BLACK);
            Paragraph info = new Paragraph(
                "Order ID: " + orderId + "\n" +
                "Customer: " + customerName + "\n" +
                "Date: " + LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")),
                infoFont
            );
            info.setSpacingBefore(10);
            info.setSpacingAfter(10);
            document.add(info);

            // -------- Table with Product Image ----------
            PdfPTable table = new PdfPTable(4); // image, name, qty, price
            table.setWidthPercentage(100);
            table.setWidths(new float[]{2.5f, 4f, 1.5f, 2f});
            table.setSpacingBefore(10f);
            table.setSpacingAfter(20f);

            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, Color.WHITE);
            String[] headers = {"Image", "Product Name", "Qty", "Price (₹)"};

            for (String head : headers) {
                PdfPCell hCell = new PdfPCell(new Phrase(head, headerFont));
                hCell.setBackgroundColor(Color.BLUE);
                hCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                hCell.setPadding(5);
                table.addCell(hCell);
            }

            // -------- Add Product Rows ----------
            for (String[] item : items) {
                String name = item[0];
                String qty = item[1];
                String price = item[2];
                String imagePath = item[3];

                // Image cell
                try {
                    Image img = Image.getInstance(imagePath);
                    img.scaleToFit(60, 60);
                    PdfPCell imgCell = new PdfPCell(img, true);
                    imgCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    imgCell.setPadding(5);
                    table.addCell(imgCell);
                } catch (Exception e) {
                    PdfPCell imgCell = new PdfPCell(new Phrase("No Image"));
                    imgCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    imgCell.setPadding(5);
                    table.addCell(imgCell);
                }

                // Other cells
                PdfPCell nameCell = new PdfPCell(new Phrase(name));
                PdfPCell qtyCell = new PdfPCell(new Phrase(qty));
                PdfPCell priceCell = new PdfPCell(new Phrase(price));

                nameCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                qtyCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                priceCell.setHorizontalAlignment(Element.ALIGN_CENTER);

                table.addCell(nameCell);
                table.addCell(qtyCell);
                table.addCell(priceCell);
            }

            document.add(table);

            // -------- Total Section ----------
//            Font totalFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.BLACK);
//            Paragraph totalPara = new Paragraph("Grand Total: ₹" + total, totalFont);
//            totalPara.setAlignment(Element.ALIGN_RIGHT);
//            totalPara.setSpacingBefore(10);
//            document.add(totalPara);
//
//            document.add(new Paragraph(" "));
         // ---- Pricing Summary ----
            Font totalFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.BLACK);

            Paragraph totalPara = new Paragraph(
                    "Total Amount: ₹" + totalAmount,
                    totalFont
            );
            totalPara.setAlignment(Element.ALIGN_RIGHT);
            totalPara.setSpacingBefore(10);
            document.add(totalPara);

            if (discountAmount > 0) {
                Font discountFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, Color.RED);
                Paragraph discountPara = new Paragraph(
                        "Discount Applied: -₹" + discountAmount,
                        discountFont
                );
                discountPara.setAlignment(Element.ALIGN_RIGHT);
                discountPara.setSpacingBefore(5);
                document.add(discountPara);
            }

            Paragraph payablePara = new Paragraph(
                    "Payable Amount: ₹" + payableAmount,
                    totalFont
            );
            payablePara.setAlignment(Element.ALIGN_RIGHT);
            payablePara.setSpacingBefore(8);
            document.add(payablePara);
            // -------- Footer ----------
            Paragraph footer = new Paragraph(
                "Thank you for shopping with E-Bazar!\nVisit us again at www.e-bazar.com",
                FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY)
            );
            footer.setAlignment(Element.ALIGN_CENTER);
            footer.setSpacingBefore(20);
            document.add(footer);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ByteArrayInputStream(out.toByteArray());
    }
}
