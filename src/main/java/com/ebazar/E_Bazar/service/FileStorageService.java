package com.ebazar.E_Bazar.service;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import jakarta.annotation.PostConstruct;
import java.io.*;
import java.nio.file.*;

@Service
public class FileStorageService {
    private final Path root;
    public FileStorageService(FileStorageProperties props) {
        this.root = Paths.get(props.getUploadDir()).toAbsolutePath().normalize();
    }
    @PostConstruct
    public void init() {
        try {
            Files.createDirectories(root);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload dir", e);
        }
    }
    public String storeFile(MultipartFile file) {
        String filename = StringUtils.cleanPath(System.currentTimeMillis() + "_" + file.getOriginalFilename());
        try {
            if (filename.contains("..")) throw new RuntimeException("Invalid path");
            Path target = root.resolve(filename);
            Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);
            return "/uploads/" + filename;
        } catch (IOException e) { throw new RuntimeException("Could not store file", e); }
    }
}
