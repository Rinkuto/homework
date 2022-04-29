package com.example.io;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Set;
import java.util.TreeMap;


public class FileSort {
    public ArrayList<String> getFilePathName(HttpServletRequest req) {
        TreeMap<Long, File> tm = new TreeMap<>(Comparator.reverseOrder());

        File[] filelist = new File(req.getServletContext().getRealPath("download")).listFiles();

        for (File value : filelist) {
            Long tempLong = value.lastModified();
            tm.put(tempLong, value);
        }

        ArrayList<String> name = new ArrayList();
        Set<Long> set = tm.keySet();
        for (Object key : set) {
            File objValue = tm.get(key);
            name.add(objValue.getName());
        }
        return name;
    }
}
