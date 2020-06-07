export function validateEntryNo(type, value, row, column, callback, target) {
  if (type !== 'blur') {
    callback();//无参或者null：不做操作
    return;
  }

  let { values } = target.getValuesSync({ validate: false });
  let count = 0;
  for (let val of values) {
    if (Number(val['entryNo']) === Number(value)) {
      if (++count >= 2) {
        callback(false, '${title}不能重复');
        return;
      }
    }
  }
  callback(true); //true：通过验证
}

export function validateByIsRubric(type, value, row, column, callback, target) {
  if (type !== 'blur') {
    callback();//无参或者null：不做操作
    return;
  }

  const v = Number(value);
  if (isNaN(v)) {
    callback();
    return;
  }

  const isRubric = Number(this.form.getFieldValue("isRubric"))
  if (isRubric === 0 && v < 0) {
    callback(false, '蓝字单${title}不能为负数');
    return;
  } else if (isRubric === 1 && v > 0) {
    callback(false, '红字单${title}不能为正数');
    return;
  }
  callback(true); //true：通过验证
}
