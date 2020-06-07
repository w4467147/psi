package io.finer.erp.jeecg.finance.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.finance.entity.FinSalInvoice;
import io.finer.erp.jeecg.finance.entity.FinSalInvoiceEntry;
import io.finer.erp.jeecg.finance.service.IFinSalInvoiceEntryService;
import io.finer.erp.jeecg.finance.service.IFinSalInvoiceService;
import io.finer.erp.jeecg.finance.vo.FinSalInvoicePage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.aspect.annotation.AutoLog;
import org.jeecg.common.system.query.QueryGenerator;
import org.jeecg.common.system.vo.LoginUser;
import org.jeecg.common.util.oConvertUtils;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.def.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.view.JeecgEntityExcelView;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
* @Description: 销售发票登记
* @Author: 
* @Date:   2020-05-24
* @Version: V1.0
*/
@Api(tags="销售发票登记")
@RestController
@RequestMapping("/finance/finSalInvoice")
@Slf4j
public class FinSalInvoiceController {
   @Autowired
   private IFinSalInvoiceService finSalInvoiceService;
   @Autowired
   private IFinSalInvoiceEntryService finSalInvoiceEntryService;
   
   /**
    * 分页列表查询
    *
    * @param finSalInvoice
    * @param pageNo
    * @param pageSize
    * @param req
    * @return
    */
   @AutoLog(value = "销售发票登记-分页列表查询")
   @ApiOperation(value="销售发票登记-分页列表查询", notes="销售发票登记-分页列表查询")
   @GetMapping(value = {"/list", "/list/{isRubric}"})
   public Result<?> queryPageList(FinSalInvoice finSalInvoice,
                                  @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
                                  @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
                                  HttpServletRequest req) {
       QueryWrapper<FinSalInvoice> queryWrapper = QueryGenerator.initQueryWrapper(finSalInvoice, req.getParameterMap());
       Page<FinSalInvoice> page = new Page<FinSalInvoice>(pageNo, pageSize);
       IPage<FinSalInvoice> pageList = finSalInvoiceService.page(page, queryWrapper);
       return Result.ok(pageList);
   }
   
   /**
    *   添加
    *
    * @param finSalInvoicePage
    * @return
    */
   @AutoLog(value = "销售发票登记-添加")
   @ApiOperation(value="销售发票登记-添加", notes="销售发票登记-添加")
   @PostMapping(value = "/add")
   public Result<?> add(@RequestBody FinSalInvoicePage finSalInvoicePage) {
       FinSalInvoice finSalInvoice = new FinSalInvoice();
       BeanUtils.copyProperties(finSalInvoicePage, finSalInvoice);
       finSalInvoiceService.saveMain(finSalInvoice, finSalInvoicePage.getFinSalInvoiceEntryList());
       return Result.ok("添加成功！");
   }
   
   /**
    *  编辑
    *
    * @param finSalInvoicePage
    * @return
    */
   @AutoLog(value = "销售发票登记-编辑")
   @ApiOperation(value="销售发票登记-编辑", notes="销售发票登记-编辑")
   @PutMapping(value = "/edit")
   public Result<?> edit(@RequestBody FinSalInvoicePage finSalInvoicePage) {
       FinSalInvoice finSalInvoice = new FinSalInvoice();
       BeanUtils.copyProperties(finSalInvoicePage, finSalInvoice);
       FinSalInvoice finSalInvoiceEntity = finSalInvoiceService.getById(finSalInvoice.getId());
       if(finSalInvoiceEntity==null) {
           return Result.error("未找到对应数据");
       }
       finSalInvoiceService.updateMain(finSalInvoice, finSalInvoicePage.getFinSalInvoiceEntryList());
       return Result.ok("编辑成功!");
   }
   
   /**
    *   通过id删除
    *
    * @param id
    * @return
    */
   @AutoLog(value = "销售发票登记-通过id删除")
   @ApiOperation(value="销售发票登记-通过id删除", notes="销售发票登记-通过id删除")
   @DeleteMapping(value = "/delete")
   public Result<?> delete(@RequestParam(name="id",required=true) String id) {
       finSalInvoiceService.delMain(id);
       return Result.ok("删除成功!");
   }
   
   /**
    *  批量删除
    *
    * @param ids
    * @return
    */
   @AutoLog(value = "销售发票登记-批量删除")
   @ApiOperation(value="销售发票登记-批量删除", notes="销售发票登记-批量删除")
   @DeleteMapping(value = "/deleteBatch")
   public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
       this.finSalInvoiceService.delBatchMain(Arrays.asList(ids.split(",")));
       return Result.ok("批量删除成功！");
   }
   
   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "销售发票登记-通过id查询")
   @ApiOperation(value="销售发票登记-通过id查询", notes="销售发票登记-通过id查询")
   @GetMapping(value = "/queryById")
   public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
       FinSalInvoice finSalInvoice = finSalInvoiceService.getById(id);
       if(finSalInvoice==null) {
           return Result.error("未找到对应数据");
       }
       return Result.ok(finSalInvoice);

   }
   
   /**
    * 通过id查询
    *
    * @param id
    * @return
    */
   @AutoLog(value = "明细通过主表ID查询")
   @ApiOperation(value="明细主表ID查询", notes="明细-通主表ID查询")
   @GetMapping(value = "/queryFinSalInvoiceEntryByMainId")
   public Result<?> queryFinSalInvoiceEntryListByMainId(@RequestParam(name="id",required=true) String id) {
       List<FinSalInvoiceEntry> finSalInvoiceEntryList = finSalInvoiceEntryService.selectByMainId(id);
       return Result.ok(finSalInvoiceEntryList);
   }

   /**
   * 导出excel
   *
   * @param request
   * @param finSalInvoice
   */
   @RequestMapping(value = {"/exportXls", "/exportXls/{isRubric}"})
   public ModelAndView exportXls(HttpServletRequest request, FinSalInvoice finSalInvoice) {
     // Step.1 组装查询条件查询数据
     QueryWrapper<FinSalInvoice> queryWrapper = QueryGenerator.initQueryWrapper(finSalInvoice, request.getParameterMap());
     LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

     //Step.2 获取导出数据
     List<FinSalInvoice> queryList = finSalInvoiceService.list(queryWrapper);
     // 过滤选中数据
     String selections = request.getParameter("selections");
     List<FinSalInvoice> finSalInvoiceList = new ArrayList<FinSalInvoice>();
     if(oConvertUtils.isEmpty(selections)) {
         finSalInvoiceList = queryList;
     }else {
         List<String> selectionList = Arrays.asList(selections.split(","));
         finSalInvoiceList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
     }

     // Step.3 组装pageList
     List<FinSalInvoicePage> pageList = new ArrayList<FinSalInvoicePage>();
     for (FinSalInvoice main : finSalInvoiceList) {
         FinSalInvoicePage vo = new FinSalInvoicePage();
         BeanUtils.copyProperties(main, vo);
         List<FinSalInvoiceEntry> finSalInvoiceEntryList = finSalInvoiceEntryService.selectByMainId(main.getId());
         vo.setFinSalInvoiceEntryList(finSalInvoiceEntryList);
         pageList.add(vo);
     }

     // Step.4 AutoPoi 导出Excel
     ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
     mv.addObject(NormalExcelConstants.FILE_NAME, "销售发票登记列表");
     mv.addObject(NormalExcelConstants.CLASS, FinSalInvoicePage.class);
     mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("销售发票登记数据", "导出人:"+sysUser.getRealname(), "销售发票登记"));
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
             List<FinSalInvoicePage> list = ExcelImportUtil.importExcel(file.getInputStream(), FinSalInvoicePage.class, params);
             for (FinSalInvoicePage page : list) {
                 FinSalInvoice po = new FinSalInvoice();
                 BeanUtils.copyProperties(page, po);
                 finSalInvoiceService.saveMain(po, page.getFinSalInvoiceEntryList());
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

    @AutoLog(value = "销售发票登记-通过id审核")
    @ApiOperation(value="销售发票登记-通过id审核", notes="销售发票登记-通过id审核")
    @PutMapping(value = "/approve")
    public Result<?> approve(@RequestBody JSONObject json) {
        finSalInvoiceService.approve(json.getString("id"));
        return Result.ok("审核通过!");
    }

}
