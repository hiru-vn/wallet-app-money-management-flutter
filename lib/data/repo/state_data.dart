class StateData<T> {
  T data;
  Exception e;
  StateData.success(this.data);
  StateData.error(this.e);
}
