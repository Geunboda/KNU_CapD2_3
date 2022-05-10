<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="javax.naming.InitialContext,javax.sql.DataSource,java.sql.*"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="includes/head.jsp" %>
<body>
<%@include file="includes/header.jsp" %>
<%
    String jndiName = "java:jboss/datasources/shtDS";
    //if(request.getParameter("jndiName") != null) {
    if (jndiName != null) {
        //  	PrintWriter writer = response.getWriter();
        out.write("<h1>Results of Test</h1>");
        //String jndiName = request.getParameter("jndiName");
        String tableName = "LETTCCMMNDETAILCODE";

        Connection conn = null;
        PreparedStatement pstmt = null;
        Statement stmt = null;
        ResultSet results = null;

        try {
            InitialContext ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup(jndiName);
            out.write("<p>Successfully looked up DataSource named " + jndiName + "</p>");

            conn = ds.getConnection();
            out.write("<p>Successfully connected to database.</p>");
            String query = "SELECT * FROM " + tableName + " where CODE_ID like ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setDouble(1, 11.1);
            pstmt.setBlob(1, new java.io.ByteArrayInputStream("test".getBytes()));
            pstmt.setString(1, "%C%");
            out.write("<p>Attempting query \"" + query + "\"</p>");
            results = pstmt.executeQuery();
            ResultSetMetaData rsMetaData = results.getMetaData();
            int numberOfColumns = rsMetaData.getColumnCount();

            out.write("<table><tr>");
            //Display the header row of column names
            for (int i = 1; i <= numberOfColumns; i++) {
                int columnType = rsMetaData.getColumnType(i);
                String columnName = rsMetaData.getColumnName(i);
                if (columnType == Types.VARCHAR) {
                    out.write("<td>" + columnName + "</td>");
                }
            }
            out.write("</tr>");
            //Print the values (VARCHAR's only) of each result
            while (results.next()) {
                out.write("<tr>");
                for (int i = 1; i <= numberOfColumns; i++) {
                    int columnType = rsMetaData.getColumnType(i);
                    String columnName = rsMetaData.getColumnName(i);
                    if (columnType == Types.VARCHAR) {
                        out.write("<td>" + results.getString(columnName) + "</td>");
                    }
                }
                out.write("</tr>");
            }
            out.write("</table>");
        } catch (Exception e) {
            out.write("An exception was thrown: " + e.getMessage() + "<br>");
            e.printStackTrace();
        } finally {
//            if(results != null) results.close();
//            if(stmt != null) stmt.close();
//            if(pstmt != null) pstmt.close();
//            if(conn != null) conn.close();
        }

    } else {

%>
<h1>Test an EAP Datasource</h1>

<form method="post">
    <table>
        <tr>
            <td>JNDI Name of Datasource:</td>
            <td><input type="text" width="60" name="jndiName"/></td>
        </tr>
        <tr>
            <td>Table Name to Query (optional):</td>
            <td><input type="text" width="60" name="tableName"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><input type="submit" value="Submit" name="submit"/></td>
        </tr>
    </table>
</form>
<% } %>
<%@include file="includes/tail.jsp" %>
</body>
</html>
