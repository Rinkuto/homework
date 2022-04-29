<%@ page import="java.io.*" %>
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
    File f = new File(path);
    File[] listFiles = new File(path).listFiles();

    f.mkdir();

    assert listFiles != null;
    if(listFiles.length == 0){ %>
        <p style="text-align: center">文件夹为空</p>
    <% } else {
        for(int i = 0;i< listFiles.length;i++){ %>
            <p style="text-align: center"><%=i+1%> <%=listFiles[i].getName()%>
                <a href="view.jsp?name=<%=listFiles[i].getName()%>">查看</a>
                <a href="delete.jsp?name=<%=listFiles[i].getName()%>">删除</a>
                <a href="download.jsp?name=<%=listFiles[i].getName()%>">下载</a>
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