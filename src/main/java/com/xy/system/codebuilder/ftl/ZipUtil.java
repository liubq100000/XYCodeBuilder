package com.xy.system.codebuilder.ftl;

import org.apache.tomcat.util.http.fileupload.IOUtils;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtil {

    /**
     * 下载指定的压缩目录
     *
     * @param target
     * @param response
     * @throws IOException
     */
    public static void downZipFile(File target, HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=code" + System.currentTimeMillis() + ".zip");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/x-msdownload");
        System.out.println("压缩文件...");
        ZipOutputStream zipout = new ZipOutputStream(response.getOutputStream());
        BufferedOutputStream bos = new BufferedOutputStream(zipout);
        zip(zipout, target, target.getName(), bos);
        bos.close();
        IOUtils.closeQuietly(zipout);
        System.out.println("压缩完成");
    }


    /**
     * 压缩
     *
     * @param zout
     * @param target
     * @param name
     * @param bos
     * @throws IOException
     */
    private static void zip(ZipOutputStream zout, File target, String name, BufferedOutputStream bos) throws IOException {
        //判断是不是目录
        if (target.isDirectory()) {
            File[] files = target.listFiles();
            if (files.length == 0) {//空目录
                zout.putNextEntry(new ZipEntry(name + "/"));
            /*  开始编写新的ZIP文件条目，并将流定位到条目数据的开头。
              关闭当前条目，如果仍然有效。 如果没有为条目指定压缩方法，
              将使用默认压缩方法，如果条目没有设置修改时间，将使用当前时间。*/
            }
            for (File f : files) {
                //递归处理
                zip(zout, f, name + "/" + f.getName(), bos);
            }
        } else {
            zout.putNextEntry(new ZipEntry(name));
            InputStream inputStream = new FileInputStream(target);
            BufferedInputStream bis = new BufferedInputStream(inputStream);
            byte[] bytes = new byte[1024];
            int len = -1;
            while ((len = bis.read(bytes)) != -1) {
                bos.write(bytes, 0, len);
            }
            bos.flush();
            bis.close();
        }
    }
}
