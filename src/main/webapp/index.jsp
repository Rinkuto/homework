<%@ page import="java.io.*" %>
<%@ page import="com.example.io.FileSort" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>主页</title>
</head>
<body>
<h1 style="text-align: center">文件列表</h1>
<%

    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

    String path = request.getServletContext().getRealPath("download");
    new File(path).mkdir();
    ArrayList<String> names = new FileSort().getFilePathName(request);

    if(names.isEmpty()){ %>
        <p style="text-align: center">文件夹为空</p>
    <% } else {
        for(int i = 0; i < names.size(); i++){ %>
            <p style="text-align: center"><%=i + 1%> <%=names.get(i)%>
                <a href="view.jsp?name=<%=names.get(i)%>">查看</a>
                <a href="delete.jsp?name=<%=names.get(i)%>">删除</a>
                <a href="download.jsp?name=<%=names.get(i)%>">下载</a>
            </p>
    <% }
    }
%>
    <div style="position: absolute;left: 50%;transform: translateX(-50%)">
        <form action="upload" method="post" enctype="multipart/form-data">
            <input type="file" name="upload">
            <br>
            <input type="submit" value="上传">
        </form>
    </div>
</body>
</html>