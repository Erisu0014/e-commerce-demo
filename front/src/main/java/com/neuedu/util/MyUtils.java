package com.neuedu.util;

import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.commons.io.FilenameUtils;
/*import org.csource.fastdfs.ClientGlobal;
import org.csource.fastdfs.StorageClient1;
import org.csource.fastdfs.TrackerClient;
import org.csource.fastdfs.TrackerServer;*/
import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartFile;

public class MyUtils {
	public static final String IMGSERVER="http://172.18.0.27/";
	/*public static String upload(MultipartFile logoImg) throws FileNotFoundException, IOException, Exception{
		String result="";
		ClassPathResource resource=new ClassPathResource("fdfs_client.conf");
		ClientGlobal.init(resource.getClassLoader().getResource("fdfs_client.conf").getPath());
		TrackerClient trackerClient=new TrackerClient();
		TrackerServer trackerServer = trackerClient.getConnection();
		StorageClient1 storageClient=new StorageClient1(trackerServer, null);
		result= storageClient.upload_file1(logoImg.getBytes(),FilenameUtils.getExtension(logoImg.getOriginalFilename()) , null);
		return result;
	}*/
}
