package io.finer.erp.jeecg.stock.controller;

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
import io.finer.erp.jeecg.stock.entity.StkInventory;
import io.finer.erp.jeecg.stock.service.IStkInventoryService;
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
import io.finer.erp.jeecg.stock.entity.StkCheckBillEntry;
import io.finer.erp.jeecg.stock.entity.StkCheckBill;
import io.finer.erp.jeecg.stock.vo.StkCheckBillPage;
import io.finer.erp.jeecg.stock.service.IStkCheckBillService;
import io.finer.erp.jeecg.stock.service.IStkCheckBillEntryService;
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
 * @Description: 盘点卡
 * @Author: jeecg-boot
 * @Date:   2020-05-18
 * @Version: V1.0
 */
@Api(tags="盘点卡")
@RestController
@RequestMapping("/stock/stkCheckBill")
@Slf4j
public class StkCheckBillController {
	@Autowired
	private IStkCheckBillService stkCheckBillService;
	@Autowired
	private IStkCheckBillEntryService stkCheckBillEntryService;
	@Autowired
	private IStkInventoryService stkInventoryService;
	
	/**
	 * 分页列表查询
	 *
	 * @param stkCheckBill
	 * @param pageNo
	 * @param pageSize
	 * @param req
	 * @return
	 */
	@AutoLog(value = "盘点卡-分页列表查询")
	@ApiOperation(value="盘点卡-分页列表查询", notes="盘点卡-分页列表查询")
	@GetMapping(value = "/list")
	public Result<?> queryPageList(StkCheckBill stkCheckBill,
								   @RequestParam(name="pageNo", defaultValue="1") Integer pageNo,
								   @RequestParam(name="pageSize", defaultValue="10") Integer pageSize,
								   HttpServletRequest req) {
		QueryWrapper<StkCheckBill> queryWrapper = QueryGenerator.initQueryWrapper(stkCheckBill, req.getParameterMap());
		Page<StkCheckBill> page = new Page<StkCheckBill>(pageNo, pageSize);
		IPage<StkCheckBill> pageList = stkCheckBillService.page(page, queryWrapper);
		return Result.ok(pageList);
	}
	
	/**
	 *   添加
	 *
	 * @param stkCheckBillPage
	 * @return
	 */
	@AutoLog(value = "盘点卡-添加")
	@ApiOperation(value="盘点卡-添加", notes="盘点卡-添加")
	@PostMapping(value = "/add")
	public Result<?> add(@RequestBody StkCheckBillPage stkCheckBillPage) {
		StkCheckBill stkCheckBill = new StkCheckBill();
		BeanUtils.copyProperties(stkCheckBillPage, stkCheckBill);
		stkCheckBillService.saveMain(stkCheckBill, stkCheckBillPage.getStkCheckBillEntryList());
		return Result.ok("添加成功！");
	}
	
	/**
	 *  编辑
	 *
	 * @param stkCheckBillPage
	 * @return
	 */
	@AutoLog(value = "盘点卡-编辑")
	@ApiOperation(value="盘点卡-编辑", notes="盘点卡-编辑")
	@PutMapping(value = "/edit")
	public Result<?> edit(@RequestBody StkCheckBillPage stkCheckBillPage) {
		StkCheckBill stkCheckBill = new StkCheckBill();
		BeanUtils.copyProperties(stkCheckBillPage, stkCheckBill);
		StkCheckBill stkCheckBillEntity = stkCheckBillService.getById(stkCheckBill.getId());
		if(stkCheckBillEntity==null) {
			return Result.error("未找到对应数据");
		}
		stkCheckBillService.updateMain(stkCheckBill, stkCheckBillPage.getStkCheckBillEntryList());
		return Result.ok("编辑成功!");
	}
	
	/**
	 *   通过id删除
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "盘点卡-通过id删除")
	@ApiOperation(value="盘点卡-通过id删除", notes="盘点卡-通过id删除")
	@DeleteMapping(value = "/delete")
	public Result<?> delete(@RequestParam(name="id",required=true) String id) {
		stkCheckBillService.delMain(id);
		return Result.ok("删除成功!");
	}
	
	/**
	 *  批量删除
	 *
	 * @param ids
	 * @return
	 */
	@AutoLog(value = "盘点卡-批量删除")
	@ApiOperation(value="盘点卡-批量删除", notes="盘点卡-批量删除")
	@DeleteMapping(value = "/deleteBatch")
	public Result<?> deleteBatch(@RequestParam(name="ids",required=true) String ids) {
		this.stkCheckBillService.delBatchMain(Arrays.asList(ids.split(",")));
		return Result.ok("批量删除成功！");
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "盘点卡-通过id查询")
	@ApiOperation(value="盘点卡-通过id查询", notes="盘点卡-通过id查询")
	@GetMapping(value = "/queryById")
	public Result<?> queryById(@RequestParam(name="id",required=true) String id) {
		StkCheckBill stkCheckBill = stkCheckBillService.getById(id);
		if(stkCheckBill==null) {
			return Result.error("未找到对应数据");
		}
		return Result.ok(stkCheckBill);
	}
	
	/**
	 * 通过id查询
	 *
	 * @param id
	 * @return
	 */
	@AutoLog(value = "明细通过主表ID查询")
	@ApiOperation(value="明细主表ID查询", notes="明细-通主表ID查询")
	@GetMapping(value = "/queryStkCheckBillEntryByMainId")
	public Result<?> queryStkCheckBillEntryListByMainId(@RequestParam(name="id",required=true) String id) {
		List<StkCheckBillEntry> stkCheckBillEntryList = stkCheckBillEntryService.selectByMainId(id);
		return Result.ok(stkCheckBillEntryList);
	}

	 @AutoLog(value = "明细通过盘点范围查询")
	 @ApiOperation(value="明细通过盘点范围查询", notes="明细-通过盘点范围查询")
	 @GetMapping(value = "/queryStkCheckBillEntryByRange")
	 public Result<?> queryStkCheckBillEntryListByRange(StkCheckBill stkCheckBill, HttpServletRequest req) {
		 QueryWrapper<StkInventory> queryWrapper = new QueryWrapper<>();
		 queryWrapper.eq("is_closed", 0);

		 String sql =   "SELECT id FROM bas_warehouse %s";
		 String where = " WHERE `code` LIKE (SELECT CONCAT(`code`, '%%') FROM bas_warehouse WHERE id = '%s')";
		 String id = stkCheckBill.getWarehouseId();
		 where = (id == null || id.isEmpty()) ? "" : String.format(where, id);
		 queryWrapper.inSql("warehouse_id", String.format(sql, where));

		 sql =   "SELECT m.id " +
			     "  FROM bas_material_category c JOIN bas_material m ON c.id = m.category_id ";
		 where = " WHERE c.code LIKE (SELECT CONCAT(`code`, '%%') FROM bas_material_category WHERE id = '%s')";
		 id = stkCheckBill.getMaterialCategoryId();
		 where = (id == null || id.isEmpty()) ? "" : String.format(where, id);
		 queryWrapper.inSql("material_id", String.format(sql, where));

		 List<StkInventory> invList = stkInventoryService.list(queryWrapper);
		 List<StkCheckBillEntry> checkList = new ArrayList<>();
		 int i = 1;
		 for(StkInventory inv:invList) {
			 StkCheckBillEntry check = new StkCheckBillEntry();
			 BeanUtils.copyProperties(inv, check,
					 "id", "qty", "remark", "remark2", "remark3", "version");
			 check.setIsNewBatch(0);
			 check.setBookQty(inv.getQty());
			 check.setEntryNo(i++);
			 checkList.add(check);
		 }
		 return Result.ok(checkList);
	 }

    /**
    * 导出excel
    *
    * @param request
    * @param stkCheckBill
    */
    @RequestMapping(value = "/exportXls")
    public ModelAndView exportXls(HttpServletRequest request, StkCheckBill stkCheckBill) {
      // Step.1 组装查询条件查询数据
      QueryWrapper<StkCheckBill> queryWrapper = QueryGenerator.initQueryWrapper(stkCheckBill, request.getParameterMap());
      LoginUser sysUser = (LoginUser) SecurityUtils.getSubject().getPrincipal();

      //Step.2 获取导出数据
      List<StkCheckBill> queryList = stkCheckBillService.list(queryWrapper);
      // 过滤选中数据
      String selections = request.getParameter("selections");
      List<StkCheckBill> stkCheckBillList = new ArrayList<StkCheckBill>();
      if(oConvertUtils.isEmpty(selections)) {
          stkCheckBillList = queryList;
      }else {
          List<String> selectionList = Arrays.asList(selections.split(","));
          stkCheckBillList = queryList.stream().filter(item -> selectionList.contains(item.getId())).collect(Collectors.toList());
      }

      // Step.3 组装pageList
      List<StkCheckBillPage> pageList = new ArrayList<StkCheckBillPage>();
      for (StkCheckBill main : stkCheckBillList) {
          StkCheckBillPage vo = new StkCheckBillPage();
          BeanUtils.copyProperties(main, vo);
          List<StkCheckBillEntry> stkCheckBillEntryList = stkCheckBillEntryService.selectByMainId(main.getId());
          vo.setStkCheckBillEntryList(stkCheckBillEntryList);
          pageList.add(vo);
      }

      // Step.4 AutoPoi 导出Excel
      ModelAndView mv = new ModelAndView(new JeecgEntityExcelView());
      mv.addObject(NormalExcelConstants.FILE_NAME, "盘点卡列表");
      mv.addObject(NormalExcelConstants.CLASS, StkCheckBillPage.class);
      mv.addObject(NormalExcelConstants.PARAMS, new ExportParams("盘点卡数据", "导出人:"+sysUser.getRealname(), "盘点卡"));
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
              List<StkCheckBillPage> list = ExcelImportUtil.importExcel(file.getInputStream(), StkCheckBillPage.class, params);
              for (StkCheckBillPage page : list) {
                  StkCheckBill po = new StkCheckBill();
                  BeanUtils.copyProperties(page, po);
                  stkCheckBillService.saveMain(po, page.getStkCheckBillEntryList());
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

	 @AutoLog(value = "库存盘点单-通过id审核")
	 @ApiOperation(value="库存盘点单-通过id审核", notes="库存盘点单-通过id审核")
	 @PutMapping(value = "/approve")
	 public Result<?> approve(@RequestBody JSONObject json) {
		 stkCheckBillService.approve(json.getString("id"));
		 return Result.ok("审核通过!");
	 }

 }
