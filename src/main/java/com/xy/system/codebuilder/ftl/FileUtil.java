package com.xy.system.codebuilder.ftl;

import java.io.File;

public class FileUtil {
    /**
     * 递归删除文件
     */
    public static void deleteFile(File dir,Long time) {
        if (!dir.exists()) {
            return;
        }
        Long overdueTime = System.currentTimeMillis() - time;
        for (File subFile : dir.listFiles()) {
            // 很古老的文件
            if (subFile.lastModified() < overdueTime) {
                deleteFile(subFile);
            }
        }
    }

    /**
     * 递归删除文件
     *
     * @param file
     */
    public static void deleteFile(File file) {
        if (file.exists()) {
            if (file.isDirectory()) {
                for (File subFile : file.listFiles()) {
                    deleteFile(subFile);
                }
            }
            file.delete();
        }
    }

}
