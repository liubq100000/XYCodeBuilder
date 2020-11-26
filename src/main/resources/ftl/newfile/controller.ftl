package ${packageName};


import cn.stylefeng.roses.core.base.controller.BaseController;
import cn.stylefeng.roses.kernel.model.response.ResponseData;
import com.yx.base.pojo.page.LayuiPageInfo;

import ${basePackage}.entity.${className};
import ${basePackage}.model.${className}Param;
import ${basePackage}.model.${className}Result;
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
* @author
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
	*
	* @author
	* @Date 2020-09-07
	*/
	@RequestMapping("/manage")
	public String index() {
		return PREFIX + "/${className2}.html";
	}

	/**
	 * 新增页面
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/add")
	public String add() {
		return PREFIX + "/${className2}Form.html";
	}

	/**
	 * 编辑页面
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/edit")
	public String edit() {
		return PREFIX + "/${className2}Form.html";
	}

	/**
	 * 新增接口
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/addItem")
	@ResponseBody
	public ResponseData addItem(${className}Param param) {
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
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/editItem")
	@ResponseBody
	public ResponseData editItem(${className}Param param) {
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
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public ResponseData delete(${className}Param param) {
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
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@RequestMapping("/detail")
	@ResponseBody
	public ResponseData detail(${className}Param param) {
		${className} detail = this.${className2}Service.getById(param.getId());
		return ResponseData.success(detail);
	}

	/**
	 * 查询列表
	 *
	 * @author
	 * @Date 2020-09-07
	 */
	@ResponseBody
	@RequestMapping("/list")
	public LayuiPageInfo list(${className}Param param) {
		return this.${className2}Service.findPageBySpec(param);
	}

}

