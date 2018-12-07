package com.neuedu.pojo;

import java.util.List;

public class ProductWithBLOBs extends Product {
    private String colorList;

    private String images;

    private String description;

    private String storageList;
    
    private List<Color>colors;
    
    private List<Storage>storages;
    
    private List<Sku>skus;

    public List<Sku> getSkus() {
		return skus;
	}

	public void setSkus(List<Sku> skus) {
		this.skus = skus;
	}

	public List<Color> getColors() {
		return colors;
	}

	public void setColors(List<Color> colors) {
		this.colors = colors;
	}

	public List<Storage> getStorages() {
		return storages;
	}

	public void setStorages(List<Storage> storages) {
		this.storages = storages;
	}

	public String getColorList() {
        return colorList;
    }

    public void setColorList(String colorList) {
        this.colorList = colorList == null ? null : colorList.trim();
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images == null ? null : images.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getStorageList() {
        return storageList;
    }

    public void setStorageList(String storageList) {
        this.storageList = storageList == null ? null : storageList.trim();
    }

	/*@Override
	public String toString() {
		return "ProductWithBLOBs [getId()=" + getId() + ", getBrandId()=" + getBrandId() + ", getName()=" + getName()
				+ ", getSales()=" + getSales() + ", getPrice()=" + getPrice() + ", getSort()=" + getSort()
				+ ", getIsDel()=" + getIsDel() + ", getIsHot()=" + getIsHot() + ", getIsNew()=" + getIsNew()
				+ ", getIsCommend()=" + getIsCommend() + ", getIsShow()=" + getIsShow() + ", getPageNo()=" + getPageNo()
				+ ", getPageSize()=" + getPageSize() + ", getWithPage()=" + getWithPage() + ", getUrl()=" + getUrl()
				+ ", getParams()=" + getParams() + ", getPages()=" + getPages() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + "]";
	}*/


    
}