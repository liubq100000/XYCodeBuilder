package com.xy.center.management.config;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import tk.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

/**
 * 
 * @MapperScan：扫描指定包的mapper作为对应数据源，建议每个数据源都用不同的包区分
 * @Qualifier：与@Autowired类似，用作区分如果存在多个实现类要指定要注入哪个 参数为指定Bean的name
 */

@Configuration
@MapperScan(basePackages = "com.xy.center", sqlSessionFactoryRef = "centerSqlSessionFactory")
public class DataSourceCenterConfig {

    /**
     * @title 生成数据源，@center注解声明为默认数据源
     * @return
     */
    @Bean(name="centerDataSoure")
    @ConfigurationProperties(prefix = "spring.datasource.druid.center")
    public DataSource centerDataSource(){
        return DataSourceBuilder.create().build();
    }

    /**
     * @title创建sqlSessionFactory
     * @param datasource
     * @return
     * @throws Exception
     */
    @Bean(name = "centerSqlSessionFactory")
    public SqlSessionFactory centerSqlSessionFactory(@Qualifier("centerDataSoure") DataSource datasource) throws Exception{
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(datasource);
        bean.setMapperLocations(new PathMatchingResourcePatternResolver() .getResources("classpath:mapper/center/**/*.xml"));
        return bean.getObject();
    }

    /**
     * @title  配置事务管理
     * @param datasource
     * @return
     */
    @Bean(name = "centerTransactionManager")
    public DataSourceTransactionManager centerTransactionManager(@Qualifier("centerDataSoure") DataSource datasource){
        return new DataSourceTransactionManager(datasource);
    }

    @Bean(name = "centerSqlSessionTemplate")
    public SqlSessionTemplate centerSqlSessionTemplate(@Qualifier("centerSqlSessionFactory") SqlSessionFactory sqlSessionFactory){
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
