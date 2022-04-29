<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.nio.charset.StandardCharsets" %><%--
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
        img{
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



    String name = request.getParameter("name"),str;
    String path = request.getServletContext().getRealPath("download") + "\\" + name;
    String suffix = name.substring(name.lastIndexOf("."));
    if (suffix.equals(".txt") || suffix.equals(".cpp")) {
        BufferedReader fin = new BufferedReader(new FileReader(path));
        %> <div class="box">
                <div class="article"><%
        while ((str = fin.readLine()) != null){
            String s = new String(str.getBytes(),StandardCharsets.UTF_8);%>
                        <p><%="    "%><%=s%></p>
        <% } %>
                </div>
        </div> <%
    fin.close();

    } else if (suffix.equals(".jpg") || suffix.equals(".png") || suffix.equals(".jpeg") || suffix.equals(".jfif")) { %>
        <img src="download/<%=name%>" alt="">
    <% } else {
    request.setAttribute("message", "查看失败");
    request.getServletContext().getRequestDispatcher("/message.jsp").forward(request, response);
    }%>
</body>
</html>
