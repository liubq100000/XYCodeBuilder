package ${packageName};


import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.kernel.model.response.ResponseData;
import com.yx.base.pojo.page.LayuiPageInfo;

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Bean;
import ${basePackage}.model.${className}Bean;
import ${basePackage}.service.I${className}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
* 控制器
*
* @author liubq
* @Date 2020-09-07 10:25:00
*/
@Controller
@RequestMapping("/${className2}")
public class ${className}Controller extends BaseController {

	private String PREFIX = "/${modulePath}/${minPath}";

	@Autowired
	private I${className}Service ${className2}Service;

	/**
	 * 跳转到主页面
	 */
	@RequestMapping("/manage")
	public String manage() {
		return PREFIX + "/${className2}.html";
	}

	/**
	 * 新增页面
	 */
	@RequestMapping("/add")
	public String add() {
		return PREFIX + "/${className2}Form.html";
	}

	/**
	 * 编辑页面
	 */
	@RequestMapping("/edit")
	public String edit() {
		return PREFIX + "/${className2}Form.html";
	}

	/**
	 * 新增接口
	 */
	@RequestMapping("/addItem")
	@ResponseBody
	public ResponseData addItem(${className}Bean param) {
		try {
			this.${className2}Service.add(param);
			return ResponseData.success();
		} catch (Exception ex) {
			ex.printStackTrace();
			return ResponseData.error(ex.getMessage());
		}
	}

	/**
	 * 编辑接口
	 */
	@RequestMapping("/editItem")
	@ResponseBody
	public ResponseData editItem(${className}Bean param) {
		try {
			this.${className2}Service.update(param);
			return ResponseData.success();
		} catch (Exception ex) {
			ex.printStackTrace();
			return ResponseData.error(ex.getMessage());
		}
	}

	/**
	 * 删除接口
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public ResponseData delete(${className}Bean param) {
		try {
			this.${className2}Service.delete(param);
			return ResponseData.success();
		} catch (Exception ex) {
			ex.printStackTrace();
			return ResponseData.error(ex.getMessage());
		}
	}

	/**
	 * 查看详情接口
	 */
	@RequestMapping("/detail")
	@ResponseBody
	public ResponseData detail(${className}Bean param) {
		${className}Bean detail = this.${className2}Service.findBySpec(param);
		return ResponseData.success(detail);
	}

	/**
	 * 查询列表
	 */
	@ResponseBody
	@RequestMapping("/list")
	public LayuiPageInfo list(${className}Bean param) {
		return this.${className2}Service.findPageBySpec(param);
	}

}

