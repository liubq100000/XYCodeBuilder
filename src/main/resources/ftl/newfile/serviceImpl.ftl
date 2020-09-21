package ${packageName};

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Param;
import ${basePackage}.model.${className}Result;
import ${basePackage}.mapper.${className}Mapper;
import ${basePackage}.service.I${className}Service;
import cn.stylefeng.roses.core.util.ToolUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yx.base.pojo.page.LayuiPageFactory;
import com.yx.base.pojo.page.LayuiPageInfo;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.List;
/** 
 * @Version 1.0
 */
@Service
public class ${className}ServiceImpl extends ServiceImpl<${className}Mapper, ${className}> implements I${className}Service {
	@Override
	public void add(${className}Param param) {
		${className} entity = getEntity(param);
		this.save(entity);
	}

	@Override
	public void delete(${className}Param param) {
		this.removeById(getKey(param));
	}

	@Override
	public void update(${className}Param param) {
		${className} oldEntity = getOldEntity(param);
		${className} newEntity = getEntity(param);
		ToolUtil.copyProperties(newEntity, oldEntity);
		this.updateById(newEntity);
	}

	@Override
	public ${className}Result findBySpec(${className}Param param) {
		List<${className}Result> list = baseMapper.customList(param);
		if (list == null || list.size() == 0) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<${className}Result> findListBySpec(${className}Param param) {
		return baseMapper.customList(param);
	}

	@Override
	public LayuiPageInfo findPageBySpec(${className}Param param) {
		Page pageContext = getPageContext();
		IPage page = this.baseMapper.customPageList(pageContext, param);
		return LayuiPageFactory.createPageInfo(page);
	}

	private Serializable getKey(${className}Param param) {
		return param.getId();
	}

	private Page getPageContext() {
		return LayuiPageFactory.defaultPage();
	}

	private ${className} getOldEntity(${className}Param param) {
		return this.getById(getKey(param));
	}

	private ${className} getEntity(${className}Param param) {
		${className} entity = new ${className}();
		ToolUtil.copyProperties(param, entity);
		return entity;
	}

}

