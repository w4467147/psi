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
import io.finer.erp.jeecg.finance.entity.FinPurInvoiceEntry;
import io.finer.erp.jeecg.finance.entity.FinPurInvoice;
import io.finer.erp.jeecg.finance.vo.FinPurInvoicePage;
import io.finer.erp.jeecg.finance.service.IFinPurInvoiceService;
import io.finer.erp.jeecg.finance.service.IFinPurInvoiceEntryService;
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
 * @Description: 采购发票登记
 * @Author: jeecg-boot
 * @Date:   2020-05-21
 * @Version: V1.0
 */
@Api(tags="采购发票登记")
@RestController
@RequestMapping("/finance/finPurInvoice")
@Slf4j
public class FinPurInvoiceController {
	@Autowired
	private IFinPurInvoiceService finPurInvoiceService;
	@Autowired
	private IFinPurInvoiceEntryService finPurInvoiceEntryService;
	
	/**
	 * 分页列表查询
	 *
	 * @param finPurInvoice
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "采购发票登记-分页列表查询")
	@ApiOperation(value="采购发票登记-分页列表查询", notes="采购发票登记-分页列表查询")
	@GetMapping(value = {"/list", "/list/{isRubric}"})
	public Result<?> queryPageList(FinPurInvoice finPurInvoice,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<FinPurInvoice> queryWrapper = QueryGenerator.initQueryWrapper(finPurInvoice, req.getParameterMap());
		Page<FinPurInvoice> page = new Page<FinPurInvoice>(pageNo, pageSize);
		IPage<FinPurInvoice> pageList = finPurInvoiceService.page(page, queryWrapper);
		return Result.ok(pageList);
	}
	
	/**
	 *   添加
	 *
	 * @param finPurInvoicePage
	 * @return
	 */
	@AutoLog(value = "采购发票登记-添加")
	@ApiOperation(value="采购发票登记-添加", notes="采购发票登记-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody FinPurInvoicePage finPurInvoicePage) {
		FinPurInvoice finPurInvoice = new FinPurInvoice();
		BeanUtils.copyProperties(finPurInvoicePage, finPurInvoice);
		finPurInvoiceService.saveMain(finPurInvoice, finPurInvoicePage.getFinPurInvoiceEntryList());
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param finPurInvoicePage
	 * @return
	 */
	@AutoLog(value = "采购发票登记-编辑")
	@ApiOperation(value="采购发票登记-编辑", notes="采购发票登记-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody FinPurInvoicePage finPurInvoicePage) {
		FinPurInvoice finPurInvoice = new FinPurInvoice();
		BeanUtils.copyProperties(finPurInvoicePage, finPurInvoice);
		FinPurInvoice finPurInvoiceEntity = finPurInvoiceService.getById(finPurInvoice.getId());
		if(finPurInvoiceEntity==null) {
			return Result.error("未找到对应数据");
		}
		finPurInvoiceService.updateMain(finPurInvoice, finPurInvoicePage.getFinPurInvoiceEntryList());
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "采购发票登记-通过id删除")
	@ApiOperation(value="采购发票登记-通过id删除", notes="采购发票登记-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		finPurInvoiceService.delMain(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "采购发票登记-批量删除")
	@ApiOperation(value="采购发票登记-批量删除", notes="采购发票登记-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.finPurInvoiceService.delBatchMain(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "采购发票登记-通过id查询")
	@ApiOperation(value="采购发票登记-通过id查询", notes="采购发票登记-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		FinPurInvoice finPurInvoice = finPurInvoiceService.getById(id);
		if(finPurInvoice==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(finPurInvoice);

	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "明细通过主表ID查询")
	@ApiOperation(value="明细主表ID查询", notes="明细-通主表ID查询")
	@GetMapping(value = "/queryFinPurInvoiceEntryByMainId")
	public Result<?> queryFinPurInvoiceEntryListByMainId(@RequestParam(name="id",required=true) String id) {
		List<FinPurInvoiceEntry> finPurInvoiceEntryList = finPurInvoiceEntryService.selectByMainId(id);
		return Result.ok(finPurInvoiceEntryList);
	}

    /**
    * 导出excel
    *
    * @param request
    * @param finPurInvoice
    */
    @RequestMapping(value = {"/exportXls", "/exportXls/{isRubric}"})
    public ModelAndView exportXls(HttpServletRequest request, FinPurInvoice finPurInvoice) {
      // Step.1 组装查询条件查询数据
      QueryWrapper<FinPurInvoice> queryWrapper = QueryGenerator.initQueryWrapper(finPurInvoice, request.getParameterMap());
      LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

      //Step.2 获取导出数据
      List<FinPurInvoice> queryList = finPurInvoiceService.list(queryWrapper);
      // 过滤选中数据
      String selections = request.getParameter("selections");
      List<FinPurInvoice> finPurInvoiceList = new ArrayList<FinPurInvoice>();
      if(oConvertUtils.isEmpty(selections)) {
          finPurInvoiceList = queryList;
      }else {
          List<String> selectionList = Arrays.asList(selections.split(","));
          finPurInvoiceList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
      }

      // Step.3 组装pageList
      List<FinPurInvoicePage> pageList = new ArrayList<FinPurInvoicePage>();
      for (FinPurInvoice main : finPurInvoiceList) {
          FinPurInvoicePage vo = new FinPurInvoicePage();
          BeanUtils.copyProperties(main, vo);
          List<FinPurInvoiceEntry> finPurInvoiceEntryList = finPurInvoiceEntryService.selectByMainId(main.getId());
          vo.setFinPurInvoiceEntryList(finPurInvoiceEntryList);
          pageList.add(vo);
      }

      // Step.4 AutoPoi 导出Excel
      ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
      mv.addObject(NormalExcelConstants.FILE_NAME, "采购发票登记列表");
      mv.addObject(NormalExcelConstants.CLASS, FinPurInvoicePage.class);
      mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("采购发票登记数据", "导出人:"+sysUser.getRealname(), "采购发票登记"));
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
              List<FinPurInvoicePage> list = ExcelImportUtil.importExcel(file.getInputStream(), FinPurInvoicePage.class, params);
              for (FinPurInvoicePage page : list) {
                  FinPurInvoice po = new FinPurInvoice();
                  BeanUtils.copyProperties(page, po);
                  finPurInvoiceService.saveMain(po, page.getFinPurInvoiceEntryList());
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

	 @AutoLog(value = "采购发票登记-通过id审核")
	 @ApiOperation(value="采购发票登记-通过id审核", notes="采购发票登记-通过id审核")
	 @PutMapping(value = "/approve")
	 public Result<?> approve(@RequestBody JSONObject json) {
		 finPurInvoiceService.approve(json.getString("id"));
		 return Result.ok("审核通过!");
	 }

 }
