<%@ page import="java.io.File" %><%--
  Created by IntelliJ IDEA.
  User: Yuri
  Date: 2022/4/27
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>删除</title>
</head>
<body>
<%

    String path = request.getServletContext().getRealPath("download") + File.separator + request.getParameter("name");
    File file = new File(path);
    if (file.delete()) {
        request.setAttribute("message", "删除成功");
    } else {
        request.setAttribute("message", "删除失败");
    }
    request.getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
%>
</body>
</html>
