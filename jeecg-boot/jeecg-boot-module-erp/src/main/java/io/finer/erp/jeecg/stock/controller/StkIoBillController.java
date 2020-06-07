package io.finer.erp.jeecg.stock.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.finer.erp.jeecg.stock.entity.StkIoBill;
import io.finer.erp.jeecg.stock.entity.StkIoBillEntry;
import io.finer.erp.jeecg.stock.service.IStkIoBillEntryService;
import io.finer.erp.jeecg.stock.service.IStkIoBillService;
import io.finer.erp.jeecg.stock.vo.StkIoBillPage;
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
 * @Description: 出入库单
 * @Author: jeecg-boot
 * @Date:   2020-03-31
 * @Version: V1.0
 */
@Api(tags="出入库单")
@RestController
@RequestMapping("/stock/stkIoBill")
@Slf4j
public class StkIoBillController {
	@Autowired
	private IStkIoBillService stkIoBillService;
	@Autowired
	private IStkIoBillEntryService stkIoBillEntryService;
	
	/**
	 * 分页列表查询
	 *
	 * @param stkIoBill
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "出入库单-分页列表查询")
	@ApiOperation(value="出入库单-分页列表查询", notes="出入库单-分页列表查询")
	@GetMapping(value = {"/list",
			"/list/{stockIoType}",
			"/list/{stockIoType}/{isRubric}"})  //stockIoType会传至stkIoBill.stockIoType
	public Result<?> queryPageList(StkIoBill stkIoBill,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<StkIoBill> queryWrapper = QueryGenerator.initQueryWrapper(stkIoBill, req.getParameterMap());
		Page<StkIoBill> page = new Page<StkIoBill>(pageNo, pageSize);
		IPage<StkIoBill> pageList = stkIoBillService.page(page, queryWrapper);
		return Result.ok(pageList);
	}

	/**
	 *   添加
	 *
	 * @param stkIoBillPage
	 * @return
	 */
	@AutoLog(value = "出入库单-添加")
	@ApiOperation(value="出入库单-添加", notes="出入库单-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody StkIoBillPage stkIoBillPage) {
		StkIoBill stkIoBill = new StkIoBill();
		BeanUtils.copyProperties(stkIoBillPage, stkIoBill);
		stkIoBillService.saveMain(stkIoBill, stkIoBillPage.getStkIoBillEntryList());
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param stkIoBillPage
	 * @return
	 */
	@AutoLog(value = "出入库单-编辑")
	@ApiOperation(value="出入库单-编辑", notes="出入库单-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody StkIoBillPage stkIoBillPage) {
		StkIoBill stkIoBill = new StkIoBill();
		BeanUtils.copyProperties(stkIoBillPage, stkIoBill);
		StkIoBill stkIoBillEntity = stkIoBillService.getById(stkIoBill.getId());
		if(stkIoBillEntity==null) {
			return Result.error("未找到对应数据");
		}
		stkIoBillService.updateMain(stkIoBill, stkIoBillPage.getStkIoBillEntryList());
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "出入库单-通过id删除")
	@ApiOperation(value="出入库单-通过id删除", notes="出入库单-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		stkIoBillService.delMain(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "出入库单-批量删除")
	@ApiOperation(value="出入库单-批量删除", notes="出入库单-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.stkIoBillService.delBatchMain(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "出入库单-通过id查询")
	@ApiOperation(value="出入库单-通过id查询", notes="出入库单-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		StkIoBill stkIoBill = stkIoBillService.getById(id);
		if(stkIoBill==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(stkIoBill);

	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "明细集合-通过id查询")
	@ApiOperation(value="明细集合-通过id查询", notes="明细-通过id查询")
	@GetMapping(value = "/queryEntryByMainId")
	public Result<?> queryEntryListByMainId(@RequestParam(name="id",required=true) String id) {
		List<StkIoBillEntry> stkIoBillEntryList = stkIoBillEntryService.selectByMainId(id);
		return Result.ok(stkIoBillEntryList);
	}

	 @AutoLog(value = "明细集合-通过id查询")
	 @ApiOperation(value="明细集合-通过id查询", notes="明细-通过id查询")
	 @GetMapping(value = "/queryEditingEntryByMainId")
	 public Result<?> queryEditingEntryListByMainId(@RequestParam(name="id",required=true) String id) {
		 List<StkIoBillEntry> stkIoBillEntryList = stkIoBillEntryService.selectEditingByMainId(id);
		 return Result.ok(stkIoBillEntryList);
	 }

    /**
    * 导出excel
    *
    * @param request
    * @param stkIoBill
    */
    @RequestMapping(value = {"/exportXls", "/exportXls/{stockIoType}"})  //stockIoType会传至stkIoBill.stockIoType
    public ModelAndView exportXls(HttpServletRequest request, StkIoBill stkIoBill) {
      // Step.1 组装查询条件查询数据
      QueryWrapper<StkIoBill> queryWrapper = QueryGenerator.initQueryWrapper(stkIoBill, request.getParameterMap());
      LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

      //Step.2 获取导出数据
      List<StkIoBill> queryList = stkIoBillService.list(queryWrapper);
      // 过滤选中数据
      String selections = request.getParameter("selections");
      List<StkIoBill> stkIoBillList = new ArrayList<StkIoBill>();
      if(oConvertUtils.isEmpty(selections)) {
          stkIoBillList = queryList;
      }else {
          List<String> selectionList = Arrays.asList(selections.split(","));
          stkIoBillList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
      }

      // Step.3 组装pageList
      List<StkIoBillPage> pageList = new ArrayList<StkIoBillPage>();
      for (StkIoBill main : stkIoBillList) {
          StkIoBillPage vo = new StkIoBillPage();
          BeanUtils.copyProperties(main, vo);
          List<StkIoBillEntry> stkIoBillEntryList = stkIoBillEntryService.selectByMainId(main.getId());
          vo.setStkIoBillEntryList(stkIoBillEntryList);
          pageList.add(vo);
      }

      // Step.4 AutoPoi 导出Excel
      ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
      mv.addObject(NormalExcelConstants.FILE_NAME, "出入库单列表");
      mv.addObject(NormalExcelConstants.CLASS, StkIoBillPage.class);
      mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("出入库单数据", "导出人:"+sysUser.getRealname(), "出入库单"));
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
              List<StkIoBillPage> list = ExcelImportUtil.importExcel(file.getInputStream(), StkIoBillPage.class, params);
              for (StkIoBillPage page : list) {
                  StkIoBill po = new StkIoBill();
                  BeanUtils.copyProperties(page, po);
                  stkIoBillService.saveMain(po, page.getStkIoBillEntryList());
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

    @AutoLog(value = "出入库单-通过id审核")
	@ApiOperation(value="出入库单-通过id审核", notes="出入库单-通过id审核")
	@PutMapping(value = "/approve")
	public Result<?> approve(@RequestBody JSONObject json) {
    	stkIoBillService.approve(json.getString("id"));
		return Result.ok("审核通过!");
    }

}
