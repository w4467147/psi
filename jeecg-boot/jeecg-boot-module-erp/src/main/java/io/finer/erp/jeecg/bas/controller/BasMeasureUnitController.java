package io.finer.erp.jeecg.bas.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.bas.entity.BasMeasureUnit;
import io.finer.erp.jeecg.bas.service.IBasMeasureUnitService;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.def.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.view.JeecgEntityExcelView;
import org.jeecg.common.system.base.controller.JeecgController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSON;

 /**
 * @Description: 计量单位
 * @Author: jeecg-boot
 * @Date:   2020-03-27
 * @Version: V1.0
 */
@RestController
@RequestMapping("/bas/basMeasureUnit")
@Slf4j
public class BasMeasureUnitController extends JeecgController<BasMeasureUnit, IBasMeasureUnitService>{
	@Autowired
	private IBasMeasureUnitService basMeasureUnitService;
	
	/**
	 * 分页列表查询
	 *
	 * @param basMeasureUnit
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@GetMapping(value = "/rootList")
	public Result<?> queryPageList(BasMeasureUnit basMeasureUnit,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		String parentId = basMeasureUnit.getPid();
		if (oConvertUtils.isEmpty(parentId)) {
			parentId = "0";
		}
		basMeasureUnit.setPid(null);
		QueryWrapper<BasMeasureUnit> queryWrapper = QueryGenerator.initQueryWrapper(basMeasureUnit, req.getParameterMap());
		// 使用 eq 防止模糊查询
		queryWrapper.eq("pid", parentId);
		Page<BasMeasureUnit> page = new Page<BasMeasureUnit>(pageNo, pageSize);
		IPage<BasMeasureUnit> pageList = basMeasureUnitService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	 /**
      * 获取子数据
      * @param testTree
      * @param req
      * @return
      */
	@GetMapping(value = "/childList")
	public Result<?> queryPageList(BasMeasureUnit basMeasureUnit,HttpServletRequest req) {
		QueryWrapper<BasMeasureUnit> queryWrapper = QueryGenerator.initQueryWrapper(basMeasureUnit, req.getParameterMap());
		List<BasMeasureUnit> list = basMeasureUnitService.list(queryWrapper);
		return Result.ok(list);
	}
	
	
	/**
	 *   添加
	 *
	 * @param basMeasureUnit
	 * @return
	 */
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody BasMeasureUnit basMeasureUnit) {
		basMeasureUnitService.addBasMeasureUnit(basMeasureUnit);
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param basMeasureUnit
	 * @return
	 */
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody BasMeasureUnit basMeasureUnit) {
		basMeasureUnitService.updateBasMeasureUnit(basMeasureUnit);
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		basMeasureUnitService.deleteBasMeasureUnit(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.basMeasureUnitService.removeByIds(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		BasMeasureUnit basMeasureUnit = basMeasureUnitService.getById(id);
		if(basMeasureUnit==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(basMeasureUnit);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param basMeasureUnit
    */
    @RequestMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, BasMeasureUnit basMeasureUnit) {
		return super.exportXls(request, basMeasureUnit, BasMeasureUnit.class, "计量单位");
    }

    /**
      * 通过excel导入数据
    *
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    public Result<?> importExcel(HttpServletRequest request, HttpServletResponse response) {
		return super.importExcel(request, response, BasMeasureUnit.class);
    }

    @GetMapping(value = "/getRate")
	public Result<?> getRate(@RequestParam(name="toId", required=true) String toId,
							 @RequestParam(name="fromId", required=true) String fromID,
							 HttpServletRequest req) {
		return Result.ok(basMeasureUnitService.getRate(toId, fromID));
	}
}
