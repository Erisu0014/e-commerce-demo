package com.neuedu.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.neuedu.dao.StorageMapper;
import com.neuedu.pojo.Storage;
import com.neuedu.pojo.StorageExample;

@Service
public class StorageServiceImpI implements IstorageService{
	@Resource
	StorageMapper storageMapper;

	@Override
	public List<Storage> getsStorages(StorageExample storageExample) {
		return storageMapper.selectByExample(storageExample);
	}

	@Override
	public Storage getStorageById(int id) {
		return storageMapper.selectByPrimaryKey(id);
	}

}
