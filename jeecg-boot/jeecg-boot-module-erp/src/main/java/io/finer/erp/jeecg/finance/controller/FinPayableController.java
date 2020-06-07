package io.finer.erp.jeecg.finance.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import io.finer.erp.jeecg.finance.entity.FinPayable;
import io.finer.erp.jeecg.finance.service.IFinPayableService;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;

import org.jeecg.common.system.base.controller.JeecgController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.jeecg.common.aspect.annotation.AutoLog;

 /**
 * @Description: 应付单
 * @Author: jeecg-boot
 * @Date:   2020-04-13
 * @Version: V1.0
 */
@Api(tags="应付单")
@RestController
@RequestMapping("/finance/finPayable")
@Slf4j
public class FinPayableController extends JeecgController<FinPayable, IFinPayableService> {
	@Autowired
	private IFinPayableService finPayableService;
	
	/**
	 * 分页列表查询
	 *
	 * @param finPayable
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "应付单-分页列表查询")
	@ApiOperation(value="应付单-分页列表查询", notes="应付单-分页列表查询")
	@GetMapping(value = {"/list", "/list/{payableType}"})  //payableType会传至finPayable.paymentType
	public Result<?> queryPageList(FinPayable finPayable,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<FinPayable> queryWrapper = QueryGenerator.initQueryWrapper(finPayable, req.getParameterMap());
		Page<FinPayable> page = new Page<FinPayable>(pageNo, pageSize);
		IPage<FinPayable> pageList = finPayableService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	 @GetMapping(value = "/checkableList")
	 public Result<?> queryCheckablePageList(FinPayable finPayable,
									@RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
									@RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
									HttpServletRequest req) {
		 QueryWrapper<FinPayable> queryWrapper = QueryGenerator.initQueryWrapper(finPayable, req.getParameterMap());
		 List<String>  list = new ArrayList<String>();
		 list.add("23");
		 list.add("31");
		 list.add("32");
		 queryWrapper.in("bill_proc_Status", list);
		 queryWrapper.eq("is_approved", 1);
		 queryWrapper.eq("is_closed", 0);
		 queryWrapper.eq("is_voided", 0);
		 queryWrapper.apply("amt - checked_amt > 0");
		 Page<FinPayable> page = new Page<FinPayable>(pageNo, pageSize);
		 IPage<FinPayable> pageList = finPayableService.page(page, queryWrapper);
		 return Result.ok(pageList);
	 }

	/**
	 *   添加
	 *
	 * @param finPayable
	 * @return
	 */
	@AutoLog(value = "应付单-添加")
	@ApiOperation(value="应付单-添加", notes="应付单-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody FinPayable finPayable) {
		finPayableService.save(finPayable);
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param finPayable
	 * @return
	 */
	@AutoLog(value = "应付单-编辑")
	@ApiOperation(value="应付单-编辑", notes="应付单-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody FinPayable finPayable) {
		finPayableService.updateById(finPayable);
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "应付单-通过id删除")
	@ApiOperation(value="应付单-通过id删除", notes="应付单-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		finPayableService.removeById(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "应付单-批量删除")
	@ApiOperation(value="应付单-批量删除", notes="应付单-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.finPayableService.removeByIds(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功!");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "应付单-通过id查询")
	@ApiOperation(value="应付单-通过id查询", notes="应付单-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		FinPayable finPayable = finPayableService.getById(id);
		if(finPayable==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(finPayable);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param finPayable
    */
    @RequestMapping(value = {"/exportXls", "/exportXls/{payableType}"})  //payableType会传至finPayable.payableType
    public ModelAndView exportXls(HttpServletRequest request, FinPayable finPayable) {
        return super.exportXls(request, finPayable, FinPayable.class, "应付单");
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
        return super.importExcel(request, response, FinPayable.class);
    }

	 @AutoLog(value = "应付单-通过id审核")
	 @ApiOperation(value="应付单-通过id审核", notes="应付单-通过id审核")
	 @PutMapping(value = "/approve")
	 public Result<?> approve(@RequestBody JSONObject json) {
		 finPayableService.approve(json.getString("id"));
		 return Result.ok("审核通过!");
	 }

 }
