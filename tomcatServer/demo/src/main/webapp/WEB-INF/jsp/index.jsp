<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%--
  ~  Opennaru, Inc. http://www.opennaru.com/
  ~
  ~  Copyright (C) 2014 Opennaru, Inc. and/or its affiliates.
  ~  All rights reserved by Opennaru, Inc.
  --%>
<html>
<%@include file="includes/head.jsp" %>
<body>

<%@include file="includes/header.jsp" %>

<br>
<hr>
<center>
    <a href=index.jsp>HOME</a>
</center>
<br><br>

<h1>OPENMARU APM Test Applications</h1>

<a href="cpu.jsp?TIME=30000">High CPU Test</a><br>
<a href="get.jsp">HttpClient GET Test</a><br>
<a href="get4.jsp">HttpClient4 GET Test</a><br>
<a href="get4.jsp">HttpClient4 GET Test</a><br>
<%--<a href="getaync.jsp">HTTP GET Async</a><br>--%>
<%--<a href="geturl.jsp">HTTP GET URL</a><br>--%>
<%--<a href="file.jsp">File Test</a><br>--%>

<a href="500.jsp">HTTP 500 Err</a><br>
<a href="500euc.jsp">HTTP 500 Error with EUC-KR encoding</a><br>
<a href="500throw.jsp">HTTP 500 Error Throw</a><br>
<a href="db2as400.jsp">DB2 AS400 Test</a><br>
<a href="db2as400callable.jsp">DB2 AS400 Callable Statement Test</a><br>
<a href="db2test.jsp">DB2/Linux Test</a><br>
<a href="db2test1.jsp">DB2/Linux Test</a><br>
<a href="dbtest2.jsp">DB Test</a><br>
<a href="deadlock.jsp">Deadlock Test</a><br>
<a href="dstest.jsp">DataSource Test</a><br>
<a href="/test/gateway/comm_/test_test.do?type=1000&url=http://www.google.com/">Gateway Test</a><br>
<a href="mem.jsp">OOM Test</a><br>
<a href="mem1.jsp">OOM Test 2</a><br>
<a href="mssqltest.jsp">MSSQL Test</a><br>
<a href="mysql_err1.jsp">MySQL SQL Err Test</a><br>
<a href="mysql_fetch1.jsp">MySQL Too many Fetch Test</a><br>
<a href="mysql_lock1.jsp">MySQL DB Lock Test</a><br>
<a href="null.jsp">Null Test</a><br>
<a href="oratest.jsp">Oracle DB Test</a><br>
<a href="oratest1.jsp">Oracle DB Test</a><br>
<a href="oratest2.jsp">Oracle DB Test</a><br>
<a href="oratest_dbleak.jsp">Oracle DB Leak Test</a> | <a href="oratest_dbleak.jsp?type=1">Oracle DB Leak Fix</a><br>
<a href="proxy.jsp?type=3">Proxy Test</a><br>
<a href="/test/query/test.do?time=3">Slow Query Test</a><br>
<a href="slow.jsp">SLOW URL Test</a><br>
<a href="slow2.jsp">SLOW URL Test</a><br>
<a href="slowtest.jsp">SLOW URL Test</a><br>
<%--<a href="socket.jsp">Socket Test</a><br>--%>
<a href="sync.jsp">Synchronized Test</a><br>
<a href="test.jsp">Test</a><br>
<a href="testnull.jsp">Test Null</a><br>
<a href="testtrace.jsp">Test Trace</a><br>
<a href="404.jsp">404 Not Found Test</a><br>

<br>
<br>

<%@include file="includes/tail.jsp" %>

</body>
</html>