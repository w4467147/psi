package io.finer.erp.jeecg.finance.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import io.finer.erp.jeecg.finance.entity.FinReceivable;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.finance.entity.FinReceivable;
import io.finer.erp.jeecg.finance.service.IFinReceivableService;

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
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.jeecg.common.aspect.annotation.AutoLog;

 /**
 * @Description: 应收单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Api(tags="应收单")
@RestController
@RequestMapping("/finance/finReceivable")
@Slf4j
public class FinReceivableController extends JeecgController<FinReceivable, IFinReceivableService> {
	@Autowired
	private IFinReceivableService finReceivableService;
	
	/**
	 * 分页列表查询
	 *
	 * @param finReceivable
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "应收单-分页列表查询")
	@ApiOperation(value="应收单-分页列表查询", notes="应收单-分页列表查询")
	@GetMapping(value = {"/list", "/list/{receivableType}"})  //cfm：receivableType会传至finPayment.paymentType
	public Result<?> queryPageList(FinReceivable finReceivable,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<FinReceivable> queryWrapper = QueryGenerator.initQueryWrapper(finReceivable, req.getParameterMap());
		Page<FinReceivable> page = new Page<FinReceivable>(pageNo, pageSize);
		IPage<FinReceivable> pageList = finReceivableService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	 @GetMapping(value = "/checkableList")
	 public Result<?> queryCheckablePageList(FinReceivable finReceivable,
											 @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
											 @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
											 HttpServletRequest req) {
		 QueryWrapper<FinReceivable> queryWrapper = QueryGenerator.initQueryWrapper(finReceivable, req.getParameterMap());
		 List<String>  list = new ArrayList<String>();
		 list.add("23");
		 list.add("31");
		 list.add("32");
		 queryWrapper.in("bill_proc_Status", list);
		 queryWrapper.eq("is_approved", 1);
		 queryWrapper.eq("is_closed", 0);
		 queryWrapper.eq("is_voided", 0);
		 queryWrapper.apply("amt - checked_amt > 0");
		 Page<FinReceivable> page = new Page<FinReceivable>(pageNo, pageSize);
		 IPage<FinReceivable> pageList = finReceivableService.page(page, queryWrapper);
		 return Result.ok(pageList);
	 }

	 /**
	 *   添加
	 *
	 * @param finReceivable
	 * @return
	 */
	@AutoLog(value = "应收单-添加")
	@ApiOperation(value="应收单-添加", notes="应收单-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody FinReceivable finReceivable) {
		finReceivableService.save(finReceivable);
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param finReceivable
	 * @return
	 */
	@AutoLog(value = "应收单-编辑")
	@ApiOperation(value="应收单-编辑", notes="应收单-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody FinReceivable finReceivable) {
		finReceivableService.updateById(finReceivable);
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "应收单-通过id删除")
	@ApiOperation(value="应收单-通过id删除", notes="应收单-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		finReceivableService.removeById(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "应收单-批量删除")
	@ApiOperation(value="应收单-批量删除", notes="应收单-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.finReceivableService.removeByIds(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功!");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "应收单-通过id查询")
	@ApiOperation(value="应收单-通过id查询", notes="应收单-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		FinReceivable finReceivable = finReceivableService.getById(id);
		if(finReceivable==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(finReceivable);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param finReceivable
    */
    @RequestMapping(value = {"/exportXls", "/exportXls/{receivableType}"})
    public ModelAndView exportXls(HttpServletRequest request, FinReceivable finReceivable) {
        return super.exportXls(request, finReceivable, FinReceivable.class, "应收单");
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
        return super.importExcel(request, response, FinReceivable.class);
    }

	@AutoLog(value = "应收单-通过id审核")
	@ApiOperation(value="应收单-通过id审核", notes="应收单-通过id审核")
	@PutMapping(value = "/approve")
	public Result<?> approve(@RequestBody JSONObject json) {
		finReceivableService.approve(json.getString("id"));
		 return Result.ok("审核通过!");
	 }

}
