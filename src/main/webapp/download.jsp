<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.io.File" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%--
  Created by IntelliJ IDEA.
  User: Yuri
  Date: 2022/4/27
  Time: 13:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>下载</title>
</head>
<body>
<%

    String name = request.getParameter("name");
    String path = request.getServletContext().getRealPath("download") + File.separator + name;
    name = URLEncoder.encode(name, StandardCharsets.UTF_8);
    response.addHeader("Content-Disposition", "attachment;filename=" + name);

    try (OutputStream os = response.getOutputStream(); FileInputStream in = new FileInputStream(path)) {
        byte[] b = new byte[1024];
        int i;

        while ((i = in.read(b)) > 0) {
            os.write(b, 0, i);
        }
        os.flush();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>
