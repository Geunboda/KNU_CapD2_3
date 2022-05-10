<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="javax.naming.InitialContext,javax.sql.DataSource,java.sql.*"
%>
<%@ page import="javax.transaction.UserTransaction" %>
<%--
  ~ Copyright (c) 2016. Opennaru, Inc.
  ~ http://www.opennaru.com/

  https://vladmihalcea.com/2014/09/14/a-beginners-guide-to-database-locking-and-the-lost-update-phenomena/
  --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="includes/head.jsp" %>
<body>
<%@include file="includes/header.jsp" %>
<%
    String jndiName = "java:jboss/datasources/mysqlDS";
    //if(request.getParameter("jndiName") != null) {
    if (jndiName != null) {
        //  	PrintWriter writer = response.getWriter();
        out.write("<h1>Results of Test</h1>");

        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        Statement stmt = null;
        ResultSet result1 = null;
        ResultSet results = null;
        UserTransaction utx = null;

        try {
            InitialContext ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup(jndiName);
            out.write("<p>Successfully looked up DataSource named " + jndiName + "</p>");

            conn = ds.getConnection();
            conn.setAutoCommit(false);
            utx =  (UserTransaction) ctx.lookup("java:jboss/UserTransaction");

            utx.begin();
            out.write("<p>Successfully connected to database.</p>");
            String query = "SELECT * FROM PRODUCT WHERE ID=? FOR UPDATE";
            pstmt1 = conn.prepareStatement(query);
            pstmt1.setInt(1, 1);

            out.write("<p>Attempting query \"" + query + "\"</p>");
            result1 = pstmt1.executeQuery();

            Thread.sleep(50);
            query = "update PRODUCT set LIKES=?, QUANTITY=? WHERE ID=?";
            pstmt2 = conn.prepareStatement(query);
            pstmt2.setInt(1, 2);
            pstmt2.setInt(2, 3);
            pstmt2.setInt(3, 1);
            pstmt2.executeUpdate();

            query = "SELECT * FROM PRODUCT WHERE ID=?";
            pstmt3 = conn.prepareStatement(query);
            pstmt3.setInt(1, 1);
            out.write("<p>Attempting query \"" + query + "\"</p>");
            results = pstmt3.executeQuery();


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
            utx.commit();
            conn.setAutoCommit(true);
        } catch (Exception e) {
            if (utx != null) utx.rollback();
            out.write("An exception was thrown: " + e.getMessage() + "<br>");
            e.printStackTrace();
        } finally {
            if (result1 != null) result1.close();
            if (results != null) results.close();
            if (stmt != null) stmt.close();
            if (pstmt1 != null) pstmt1.close();
            if (pstmt2 != null) pstmt2.close();
            if (pstmt3 != null) pstmt3.close();
            if (conn != null) conn.close();
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