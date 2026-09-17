package com.ebazar.E_Bazar;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import com.ebazar.E_Bazar.service.FileStorageProperties;

@SpringBootApplication
@EnableConfigurationProperties(FileStorageProperties.class)
public class EBazarApplication {

	public static void main(String[] args) {
		SpringApplication.run(EBazarApplication.class, args);
	}

}
