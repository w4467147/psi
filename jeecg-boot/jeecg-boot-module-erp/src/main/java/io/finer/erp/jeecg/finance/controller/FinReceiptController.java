package io.finer.erp.jeecg.finance.controller;

import java.io.UnsupportedEncodingException;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.def.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.view.JeecgEntityExcelView;
import org.jeecg.common.system.vo.LoginUser;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.util.oConvertUtils;
import io.finer.erp.jeecg.finance.entity.FinReceiptEntry;
import io.finer.erp.jeecg.finance.entity.FinReceipt;
import io.finer.erp.jeecg.finance.vo.FinReceiptPage;
import io.finer.erp.jeecg.finance.service.IFinReceiptService;
import io.finer.erp.jeecg.finance.service.IFinReceiptEntryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.extern.slf4j.Slf4j;
import com.alibaba.fastjson.JSON;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.jeecg.common.aspect.annotation.AutoLog;

 /**
 * @Description: 收款单
 * @Author: jeecg-boot
 * @Date:   2020-04-30
 * @Version: V1.0
 */
@Api(tags="收款单")
@RestController
@RequestMapping("/finance/finReceipt")
@Slf4j
public class FinReceiptController {
	@Autowired
	private IFinReceiptService finReceiptService;
	@Autowired
	private IFinReceiptEntryService finReceiptEntryService;
	
	/**
	 * 分页列表查询
	 *
	 * @param finReceipt
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "收款单-分页列表查询")
	@ApiOperation(value="收款单-分页列表查询", notes="收款单-分页列表查询")
	@GetMapping(value = {"/list", "/list/{receiptType}"})  //receiptType会传至finReceiptType.receiptTypeType
	public Result<?> queryPageList(FinReceipt finReceipt,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<FinReceipt> queryWrapper = QueryGenerator.initQueryWrapper(finReceipt, req.getParameterMap());
		Page<FinReceipt> page = new Page<FinReceipt>(pageNo, pageSize);
		IPage<FinReceipt> pageList = finReceiptService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	 @GetMapping(value = "/checkableList")
	 public Result<?> queryCheckablePageList(FinReceipt finReceipt,
											 @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
											 @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
											 HttpServletRequest req) {
		 QueryWrapper<FinReceipt> queryWrapper = QueryGenerator.initQueryWrapper(finReceipt, req.getParameterMap());
		 List<String>  list = new ArrayList<String>();
		 list.add("23");
		 list.add("31");
		 list.add("32");
		 queryWrapper.in("bill_proc_Status", list);
		 queryWrapper.eq("is_approved", 1);
		 queryWrapper.eq("is_closed", 0);
		 queryWrapper.eq("is_voided", 0);
		 queryWrapper.apply("amt - deducted_amt - checked_amt > 0");
		 Page<FinReceipt> page = new Page<FinReceipt>(pageNo, pageSize);
		 IPage<FinReceipt> pageList = finReceiptService.page(page, queryWrapper);
		 return Result.ok(pageList);
	 }

	 /**
	 *   添加
	 *
	 * @param finReceiptPage
	 * @return
	 */
	@AutoLog(value = "收款单-添加")
	@ApiOperation(value="收款单-添加", notes="收款单-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody FinReceiptPage finReceiptPage) {
		FinReceipt finReceipt = new FinReceipt();
		BeanUtils.copyProperties(finReceiptPage, finReceipt);
		finReceiptService.saveMain(finReceipt, finReceiptPage.getFinReceiptEntryList());
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param finReceiptPage
	 * @return
	 */
	@AutoLog(value = "收款单-编辑")
	@ApiOperation(value="收款单-编辑", notes="收款单-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody FinReceiptPage finReceiptPage) {
		FinReceipt finReceipt = new FinReceipt();
		BeanUtils.copyProperties(finReceiptPage, finReceipt);
		FinReceipt finReceiptEntity = finReceiptService.getById(finReceipt.getId());
		if(finReceiptEntity==null) {
			return Result.error("未找到对应数据");
		}
		finReceiptService.updateMain(finReceipt, finReceiptPage.getFinReceiptEntryList());
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "收款单-通过id删除")
	@ApiOperation(value="收款单-通过id删除", notes="收款单-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		finReceiptService.delMain(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "收款单-批量删除")
	@ApiOperation(value="收款单-批量删除", notes="收款单-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.finReceiptService.delBatchMain(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "收款单-通过id查询")
	@ApiOperation(value="收款单-通过id查询", notes="收款单-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		FinReceipt finReceipt = finReceiptService.getById(id);
		if(finReceipt==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(finReceipt);

	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "收款明细集合-通过id查询")
	@ApiOperation(value="收款明细集合-通过id查询", notes="收款明细-通过id查询")
	@GetMapping(value = "/queryFinReceiptEntryByMainId")
	public Result<?> queryFinReceiptEntryListByMainId(@RequestParam(name="id",required=true) String id) {
		List<FinReceiptEntry> finReceiptEntryList = finReceiptEntryService.selectByMainId(id);
		return Result.ok(finReceiptEntryList);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param finReceipt
    */
    @RequestMapping(value = {"/exportXls", "/exportXls/{receiptType}"})
    public ModelAndView exportXls(HttpServletRequest request, FinReceipt finReceipt) {
      // Step.1 组装查询条件查询数据
      QueryWrapper<FinReceipt> queryWrapper = QueryGenerator.initQueryWrapper(finReceipt, request.getParameterMap());
      LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

      //Step.2 获取导出数据
      List<FinReceipt> queryList = finReceiptService.list(queryWrapper);
      // 过滤选中数据
      String selections = request.getParameter("selections");
      List<FinReceipt> finReceiptList = new ArrayList<FinReceipt>();
      if(oConvertUtils.isEmpty(selections)) {
          finReceiptList = queryList;
      }else {
          List<String> selectionList = Arrays.asList(selections.split(","));
          finReceiptList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
      }

      // Step.3 组装pageList
      List<FinReceiptPage> pageList = new ArrayList<FinReceiptPage>();
      for (FinReceipt main : finReceiptList) {
          FinReceiptPage vo = new FinReceiptPage();
          BeanUtils.copyProperties(main, vo);
          List<FinReceiptEntry> finReceiptEntryList = finReceiptEntryService.selectByMainId(main.getId());
          vo.setFinReceiptEntryList(finReceiptEntryList);
          pageList.add(vo);
      }

      // Step.4 AutoPoi 导出Excel
      ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
      mv.addObject(NormalExcelConstants.FILE_NAME, "收款单列表");
      mv.addObject(NormalExcelConstants.CLASS, FinReceiptPage.class);
      mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("收款单数据", "导出人:"+sysUser.getRealname(), "收款单"));
      mv.addObject(NormalExcelConstants.DATA_LIST, pageList);
      return mv;
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
      MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
      Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
      for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
          MultipartFile file = entity.getValue();// 获取上传文件对象
          ImportParams params = new ImportParams();
          params.setTitleRows(2);
          params.setHeadRows(1);
          params.setNeedSave(true);
          try {
              List<FinReceiptPage> list = ExcelImportUtil.importExcel(file.getInputStream(), FinReceiptPage.class, params);
              for (FinReceiptPage page : list) {
                  FinReceipt po = new FinReceipt();
                  BeanUtils.copyProperties(page, po);
                  finReceiptService.saveMain(po, page.getFinReceiptEntryList());
              }
              return Result.ok("文件导入成功！数据行数:" + list.size());
          } catch (Exception e) {
              log.error(e.getMessage(),e);
              return Result.error("文件导入失败:"+e.getMessage());
          } finally {
              try {
                  file.getInputStream().close();
              } catch (IOException e) {
                  e.printStackTrace();
              }
          }
      }
      return Result.ok("文件导入失败！");
    }

	 @AutoLog(value = "收款单-通过id审核")
	 @ApiOperation(value="收款单-通过id审核", notes="收款单-通过id审核")
	 @PutMapping(value = "/approve")
	 public Result<?> approve(@RequestBody JSONObject json) {
		 finReceiptService.approve(json.getString("id"));
		 return Result.ok("审核通过!");
	 }
}
