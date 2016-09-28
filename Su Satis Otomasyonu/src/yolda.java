
import java.sql.ResultSet;
import javax.swing.table.DefaultTableModel;


public class yolda extends javax.swing.JFrame {

    
    public yolda() {
        initComponents();
        tablodoldur();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        jTable1 = new javax.swing.JTable();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jScrollPane1.setViewportView(jTable1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 390, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 275, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(14, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public static void main(String args[]) {
        
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new yolda().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable jTable1;
    // End of variables declaration//GEN-END:variables

    private void tablodoldur() {
        DefaultTableModel dt = new DefaultTableModel();

        dt.addColumn("Müşteri");
        dt.addColumn("Sipariş Durumu");
        dt.addColumn("Adet");
        dt.addColumn("Fiyat");

        try {
            DB db = new DB();
            int fiyat = 0;
            ResultSet rs = db.baglan().executeQuery("select * from siparisler left join sucinsi ON siparisler.tur_id=sucinsi.tur_id LEFT JOIN musteriler ON musteriler.musteri_id=siparisler.musteri_id where durum='yolda'");
            while (rs.next()) {
                fiyat = Integer.parseInt(rs.getString("fiyat").toString()) * Integer.parseInt(rs.getString("adet").toString());

                dt.addRow(new String[]{rs.getString("adi") + " " + rs.getString("soyadi"), rs.getString("durum"), rs.getString("adet"), rs.getString("fiyat"), fiyat + ""});

            }
            jTable1.setModel(dt);

        } catch (Exception e) {
        }
    }
}
