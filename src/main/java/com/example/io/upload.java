package com.example.io;

import com.oreilly.servlet.MultipartRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/upload")
public class upload extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final int MAX_FILE_SIZE = 1024 * 1024 * 50; // 20MB

    protected String newname(String path) {
        File f = new File(path);
        String name = f.getName();
        String parent = f.getParent();
        String t1 = name.substring(0, name.lastIndexOf("."));
        String t2 = name.substring(name.lastIndexOf("."));
        int i = 1;
        while (f.exists()) {
            name = t1 + "(" + i + ")" + t2;
            f = new File(parent + File.separator + name);
            i++;
        }
        return name;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String saveDirectory = req.getServletContext().getRealPath("/");//服务器上存储路径
        MultipartRequest multi = new MultipartRequest(req, saveDirectory, MAX_FILE_SIZE, "UTF-8");
        Enumeration efs = multi.getFileNames();

        while (efs.hasMoreElements()) {
            File file = multi.getFile(efs.nextElement().toString());
            if (file == null) {
                req.setAttribute("message", "文件为空");
                getServletContext().getRequestDispatcher("/message.jsp").forward(req, resp);
                return;
            }

            String fname = file.getName();//附件原名
            String filePath = req.getServletContext().getRealPath("download");

            //重新命名文件
            fname = newname(filePath + File.separator + fname);

            File newfile = new File(filePath + File.separator + fname);
            file.renameTo(newfile);
        }
        req.setAttribute("message", "文件上传成功");
        getServletContext().getRequestDispatcher("/message.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
