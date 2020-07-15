package com.xy.center.management.config;//package com.xy.center.management.config;
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
import org.springframework.context.annotation.Primary;
import javax.sql.DataSource;

/**
 *
 * @MapperScan：扫描指定包的mapper作为对应数据源，建议每个数据源都用不同的包区分
 * @Qualifier：与@Autowired类似，用作区分如果存在多个实现类要指定要注入哪个 参数为指定Bean的name
 */

@Configuration
@MapperScan(basePackages = "com.xy.system", sqlSessionFactoryRef = "systemSqlSessionFactory")
public class DataSourceSystemConfig {

    /**
     * @title 生成数据源，@system注解声明为默认数据源
     * @return
     */
    @Bean(name="systemDataSoure")
    @Primary
    @ConfigurationProperties(prefix = "spring.datasource.druid.system")
    public DataSource systemDataSource(){
        return DataSourceBuilder.create().build();
    }

    /**
     * @title 创建sqlSessionFactory
     * @param datasource
     * @return
     * @throws Exception
     */
    @Bean(name = "systemSqlSessionFactory")
    @Primary
    public SqlSessionFactory systemSqlSessionFactory(@Qualifier("systemDataSoure") DataSource datasource) throws Exception{
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(datasource);
        bean.setMapperLocations(new PathMatchingResourcePatternResolver() .getResources("mapper/system/**/*.xml"));
        return bean.getObject();
    }

    /**
     * @title  配置事务管理
     * @param datasource
     * @return
     */
    @Bean(name = "systemTransactionManager")
    @Primary
    public DataSourceTransactionManager systemTransactionManager(@Qualifier("systemDataSoure") DataSource datasource){
        return new DataSourceTransactionManager(datasource);
    }

    @Bean(name = "systemSqlSessionTemplate")
    @Primary
    public SqlSessionTemplate systemSqlSessionTemplate(@Qualifier("systemSqlSessionFactory") SqlSessionFactory sqlSessionFactory){
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
