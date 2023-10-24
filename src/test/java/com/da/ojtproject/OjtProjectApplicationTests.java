package com.da.ojtproject;

import com.da.ojtproject.admin.dao.AdminDao;
import com.da.ojtproject.admin.domain.Domain;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import javax.sql.DataSource;

@Transactional
@SpringBootTest
@Slf4j
class OjtProjectApplicationTests {

	@Autowired
	AdminDao adminDao;

	@Autowired
	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public OjtProjectApplicationTests(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Test
	@DisplayName(value = "테스트 DB 작동 확인")
	void contextLoads() {
		adminDao.saveAdmin("1111");
	}
}
