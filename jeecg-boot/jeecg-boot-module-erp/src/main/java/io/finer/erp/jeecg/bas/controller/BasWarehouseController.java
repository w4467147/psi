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
import io.finer.erp.jeecg.bas.entity.BasWarehouse;
import io.finer.erp.jeecg.bas.service.IBasWarehouseService;

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
 * @Description: 仓库
 * @Author: jeecg-boot
 * @Date:   2020-04-01
 * @Version: V1.0
 */
@RestController
@RequestMapping("/bas/basWarehouse")
@Slf4j
public class BasWarehouseController extends JeecgController<BasWarehouse, IBasWarehouseService>{
	@Autowired
	private IBasWarehouseService basWarehouseService;
	
	/**
	 * 分页列表查询
	 *
	 * @param basWarehouse
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@GetMapping(value = "/rootList")
	public Result<?> queryPageList(BasWarehouse basWarehouse,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		String parentId = basWarehouse.getPid();
		if (oConvertUtils.isEmpty(parentId)) {
			parentId = "0";
		}
		basWarehouse.setPid(null);
		QueryWrapper<BasWarehouse> queryWrapper = QueryGenerator.initQueryWrapper(basWarehouse, req.getParameterMap());
		// 使用 eq 防止模糊查询
		queryWrapper.eq("pid", parentId);
		Page<BasWarehouse> page = new Page<BasWarehouse>(pageNo, pageSize);
		IPage<BasWarehouse> pageList = basWarehouseService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	 /**
      * 获取子数据
      * @param testTree
      * @param req
      * @return
      */
	@GetMapping(value = "/childList")
	public Result<?> queryPageList(BasWarehouse basWarehouse,HttpServletRequest req) {
		QueryWrapper<BasWarehouse> queryWrapper = QueryGenerator.initQueryWrapper(basWarehouse, req.getParameterMap());
		List<BasWarehouse> list = basWarehouseService.list(queryWrapper);
		return Result.ok(list);
	}
	
	
	/**
	 *   添加
	 *
	 * @param basWarehouse
	 * @return
	 */
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody BasWarehouse basWarehouse) {
		basWarehouseService.addBasWarehouse(basWarehouse);
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param basWarehouse
	 * @return
	 */
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody BasWarehouse basWarehouse) {
		basWarehouseService.updateBasWarehouse(basWarehouse);
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
		basWarehouseService.deleteBasWarehouse(id);
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
		this.basWarehouseService.removeByIds(Arrays.asList(ids.split(",")));
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
		BasWarehouse basWarehouse = basWarehouseService.getById(id);
		if(basWarehouse==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(basWarehouse);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param basWarehouse
    */
    @RequestMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, BasWarehouse basWarehouse) {
		return super.exportXls(request, basWarehouse, BasWarehouse.class, "仓库");
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
		return super.importExcel(request, response, BasWarehouse.class);
    }

}
