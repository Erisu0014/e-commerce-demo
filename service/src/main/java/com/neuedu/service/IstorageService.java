package com.neuedu.service;

import java.util.List;

import com.neuedu.pojo.Storage;
import com.neuedu.pojo.StorageExample;

public interface IstorageService {
	public List<Storage>getsStorages(StorageExample storageExample);
	public Storage getStorageById(int id);

}
