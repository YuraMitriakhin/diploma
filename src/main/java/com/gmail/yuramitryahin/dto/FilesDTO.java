package com.gmail.yuramitryahin.dto;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;

public class FilesDTO {
    private MultipartFile[] files;
    private String[] description;

    public FilesDTO() {
    }

    public FilesDTO(MultipartFile[] files, String[] description) {
        this.files = files;
        this.description = description;
    }

    public MultipartFile[] getFiles() {
        return files;
    }

    public void setFiles(MultipartFile[] files) {
        this.files = files;
    }

    public String[] getDescription() {
        return description;
    }

    public void setDescription(String[] description) {
        this.description = description;
    }
}
