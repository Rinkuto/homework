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

    private static final int MAX_FILE_SIZE = 1024 * 1024 * 20; // 20MB

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletContext().getRealPath("download");
        MultipartRequest mr = new MultipartRequest(req, path, MAX_FILE_SIZE, "UTF-8");
        Enumeration files = mr.getFileNames();
        // 获取文件名字
//        String name = mr.getFile(files.nextElement().toString()).getName();

        String fileName;
        while (files.hasMoreElements()) {
            fileName = (String) files.nextElement();
            File f = mr.getFile(fileName);
            System.out.println(f);
            if (null == f) {
                req.setAttribute("message", "文件不存在");
                getServletContext().getRequestDispatcher("/message.jsp").forward(req, resp);
                return;
            } else {
                req.setAttribute("message", "文件上传成功!");
            }
//            save(path, f);
        }
        getServletContext().getRequestDispatcher("/message.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
}
