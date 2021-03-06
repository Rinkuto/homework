<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %><%--
  Created by IntelliJ IDEA.
  User: Yuri
  Date: 2022/4/27
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="utf-8" %>
<html>
<head>
    <title>查看</title>
    <style>
        img {
            object-fit: cover;
            display: block;
            height: 100%;
            margin: auto;
            background-color: hsl(0, 0%, 90%);
            transition: background-color 300ms;
        }

        .box {
            position: relative;
            width: 800px;
            height: 100%;
            left: 50%;
            background-color: #f6f6f6;
            transform: translateX(-50%);
        }

        .box .article {
            position: relative;
            padding: 0 58px;
            border-radius: 3px;
            box-shadow: 0 1px 4px rgb(0 0 0 / 20%);
        }

        div p {
            position: relative;
            word-wrap: break-word;
            word-break: break-all;
            line-height: 2.14286;
            font-size: 16px;
        }
    </style>
</head>

<body>
<%
    String name = request.getParameter("name"), str;
    String path = request.getServletContext().getRealPath("download") + "\\" + name;
    String suffix = name.substring(name.lastIndexOf("."));
    name = URLEncoder.encode(name, StandardCharsets.UTF_8);
    if (suffix.equals(".txt") || suffix.equals(".cpp")) {
        FileInputStream in = new FileInputStream(new File(path));
        InputStreamReader read = new InputStreamReader(in, StandardCharsets.UTF_8);
        BufferedReader bin = new BufferedReader(read);
%>
<div class="box">
    <div class="article"><%
        while ((str = bin.readLine()) != null) {%>
        <p><%=str%>
        </p>
        <% } %>
    </div>
</div>
<%
    bin.close();
} else if (suffix.equals(".jpg") || suffix.equals(".png") || suffix.equals(".jpeg") || suffix.equals(".jfif") || suffix.equals(".webp")) {
    response.sendRedirect("download/" + name); %>
<%--<img src="download/<%=name%>" alt="">--%>
<% } else {
    request.setAttribute("message", "不允许查看" + suffix + "文件");
    request.getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
}%>
</body>
</html>
