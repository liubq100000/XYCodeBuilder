package ${packageName};

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Bean;
import ${basePackage}.mapper.${className}Mapper;
import ${basePackage}.service.I${className}Service;
import cn.stylefeng.roses.core.util.ToolUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yx.base.pojo.page.LayuiPageFactory;
import com.yx.base.pojo.page.LayuiPageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.yx.core.util.XyListUtil;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/** 
 * @Version 1.0
 */
@Service
public class ${className}ServiceImpl extends ServiceImpl<${className}Mapper, ${className}> implements I${className}Service {
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void add(${className}Bean param) throws Exception{
		${className} entity = getEntity(param);
		this.save(entity);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void update(${className}Bean param) throws Exception{
		${className} newEntity = getEntity(param);
		this.updateById(newEntity);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void delete(${className}Bean param) throws Exception{
		this.removeById(getKey(param));
	}

	@Override
	public ${className}Bean findBySpec(${className}Bean param) {
		List<${className}Bean> list = baseMapper.customList(param);
		if (list == null || list.size() == 0) {
			return null;
		}
		return list.get(0);
	}

	<#if hasHeadId=="Y">
	@Override
	public List<${className}Bean> queryByHeadIds(String heads) {
		Long[] ids = XyListUtil.toLongArr(heads);
		if (ids.length == 0) {
			return new ArrayList<>();
		}
		${className}Bean cond = new ${className}Bean();
		cond.setHeadIdList(ids);
		List<${className}Bean> list = baseMapper.customList(cond);
		if (list == null || list.size() == 0) {
			return new ArrayList<>();
		}
		return list;
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteByHeadIds(String heads) {
		Long[] ids = XyListUtil.toLongArr(heads);
		if (ids.length == 0) {
			return;
		}
		for(Long headId : ids){
			Map<String, Object> columnMap = new HashMap<>();
			columnMap.put("head_id", headId);
			this.removeByMap(columnMap);
		}
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteByHeadId(Long headId) {
		Map<String, Object> columnMap = new HashMap<>();
		columnMap.put("head_id", headId);
		this.removeByMap(columnMap);
	}
	</#if>


	@Override
	public List<${className}Bean> findListBySpec(${className}Bean param) {
		return baseMapper.customList(param);
	}

	@Override
	public LayuiPageInfo findPageBySpec(${className}Bean param) {
		Page pageContext = getPageContext();
		IPage page = this.baseMapper.customPageList(pageContext, param);
		return LayuiPageFactory.createPageInfo(page);
	}

	private Serializable getKey(${className}Bean param) {
		return param.getId();
	}

	private Page getPageContext() {
		return LayuiPageFactory.defaultPage();
	}

	private ${className} getEntity(${className}Bean param) {
		${className} entity = new ${className}();
		ToolUtil.copyProperties(param, entity);
		return entity;
	}

}

